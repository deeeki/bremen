require 'json'
require 'bremen/base'

module Bremen
  class Mixcloud < Bremen::Base
    BASE_URL = 'http://api.mixcloud.com/'
    self.default_options = {
      keyword: '',
      limit: 20,
    }

    class << self
      def find_url uid_or_url
        if uid_or_url.to_s.include?('www.mixcloud.com')
          uid_or_url.sub('www.mixcloud.com', 'api.mixcloud.com')
        else
          "#{BASE_URL[0..-2]}#{uid_or_url}"
        end
      end

      def search_url options = {}
        options = default_options.merge(options)
        query = {
          q: options[:keyword],
          limit: options[:limit],
          type: 'cloudcast',
        }
        "#{BASE_URL}search/?#{build_query(query)}"
      end

      def from_api hash = {}
        created_at = Time.parse(hash['created_time'])
        new({
          uid: hash['key'],
          url: hash['url'],
          title: hash['name'],
          author: Bremen::Author.new({
            uid: hash['user']['key'],
            url: hash['user']['url'],
            name: hash['user']['name'],
            thumbnail_url: hash['user']['pictures']['medium'],
          }),
          length: hash['audio_length'].to_i,
          thumbnail_url: hash['pictures']['medium'],
          created_at: created_at,
          updated_at: created_at,
        })
      end

      private
      def convert_singly response
        from_api(JSON.parse(response))
      end

      def convert_multiply response
        JSON.parse(response)['data'].map{|t| from_api(t) }
      end
    end
  end
end
