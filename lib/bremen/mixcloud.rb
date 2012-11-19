require 'json'
require 'bremen/base'

module Bremen
  class Mixcloud < Bremen::Base
    BASE_URL = 'http://api.mixcloud.com/search/'
    self.default_options = {
      keyword: '',
      limit: 20,
    }

    class << self
      def search_url options = {}
        options = default_options.merge(options)
        query = {
          q: options[:keyword],
          limit: options[:limit],
          type: 'cloudcast',
        }
        "#{BASE_URL}?#{build_query(query)}"
      end

      def from_api hash = {}
        created_at = Time.parse(hash['created_time'])
        new({
          uid: hash['key'],
          url: hash['url'],
          title: hash['name'],
          author: hash['user']['name'],
          length: hash['audio_length'].to_i,
          created_at: created_at,
          updated_at: created_at,
        })
      end

      private
      def convert_from_response response
        JSON.parse(response)['data'].map{|t| from_api(t) }
      end
    end
  end
end
