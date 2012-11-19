require 'json'
require 'bremen/base'

module Bremen
  class Soundcloud < Bremen::Base
    BASE_URL = 'http://api.soundcloud.com/tracks.json'
    self.default_options = {
      keyword: '',
      order: 'created_at', #created_at/hotness
      limit: 50,
      filter: '', #(all)/public/private/streamable/downloadable
    }

    class << self
      attr_accessor :consumer_key

      def search_url options = {}
        raise %Q{"#{self.name}.consumer_key" must be set} unless consumer_key
        options = default_options.merge(options)
        query = {
          q: options[:keyword],
          order: options[:order],
          limit: options[:limit],
          filter: options[:filter],
          consumer_key: consumer_key,
        }
        "#{BASE_URL}?#{build_query(query)}"
      end

      def from_api hash = {}
        new({
          uid: hash['id'],
          url: hash['permalink_url'],
          title: hash['title'],
          author: hash['user']['username'],
          length: (hash['duration'].to_i / 1000).round,
          created_at: Time.parse(hash['created_at']),
          updated_at: Time.parse(hash['created_at']),
        })
      end

      private
      def convert_from_response response
        JSON.parse(response).map{|t| from_api(t) }
      end
    end
  end
end
