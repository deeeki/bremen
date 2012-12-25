require 'json'
require 'bremen/base'

module Bremen
  class Soundcloud < Bremen::Base
    BASE_URL = 'http://api.soundcloud.com/'
    self.default_options = {
      keyword: '',
      order: 'created_at', #created_at/hotness
      limit: 50,
      page: 1,
      filter: '', #(all)/public/private/streamable/downloadable
    }

    class << self
      attr_accessor :client_id

      def build_query options = {}
        raise %Q{"#{self.name}.client_id" must be set} unless client_id
        super(options.merge(client_id: client_id))
      end

      def find_url uid_or_url
        if uid_or_url.to_s =~ %r{\A\d+\Z}
          "#{BASE_URL}tracks/#{uid_or_url}.json?#{build_query}"
        else
          "#{BASE_URL}resolve.json?#{build_query({url: uid_or_url})}"
        end
      end

      def search_url options = {}
        options = default_options.merge(options)
        query = {
          q: options[:keyword],
          order: options[:order],
          limit: options[:limit],
          offset: options[:limit] * (options[:page] - 1),
          filter: options[:filter],
        }
        "#{BASE_URL}tracks.json?#{build_query(query)}"
      end

      def from_api hash = {}
        created_at = Time.parse(hash['created_at']).utc
        new({
          uid: hash['id'].to_s,
          url: hash['permalink_url'],
          title: hash['title'],
          author: Bremen::Author.new({
            uid: hash['user']['id'].to_s,
            url: hash['user']['permalink_url'],
            name: hash['user']['username'],
            thumbnail_url: hash['user']['avatar_url'].sub(%r{\?.*}, ''),
          }),
          length: (hash['duration'].to_i / 1000).round,
          thumbnail_url: hash['artwork_url'] ? hash['artwork_url'].sub(%r{\?.*}, '') : nil,
          created_at: created_at,
          updated_at: created_at,
        })
      end

      private
      def convert_singly response
        from_api(JSON.parse(response))
      end

      def convert_multiply response
        JSON.parse(response).map{|t| from_api(t) }
      end
    end
  end
end
