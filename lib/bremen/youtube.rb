require 'json'
require 'bremen/base'

module Bremen
  class Youtube < Bremen::Base
    BASE_URL = 'http://gdata.youtube.com/feeds/api/videos/'
    self.default_options = {
      order: 'published', #relevance/published/viewCount/rating
      limit: 25,
      category: 'Music',
      tag: '',
    }

    class << self
      def search_url options = {}
        options = default_options.merge(options)
        query = {
          vq: options[:keyword],
          orderby: options[:order],
          :"max-results" => options[:limit],
          alt: 'json',
        }
        "#{BASE_URL}-/#{options[:category]}/#{options[:tag]}/?#{build_query(query)}"
      end

      def from_api hash = {}
        uid = hash['id']['$t'].sub('http://gdata.youtube.com/feeds/api/videos/', '')
        new({
          uid: uid,
          url: "http://www.youtube.com/watch?v=#{uid}",
          title: hash['title']['$t'],
          author: hash['author'].first['name']['$t'],
          length: hash['media$group']['yt$duration']['seconds'].to_i,
          created_at: Time.parse(hash['published']['$t']),
          updated_at: Time.parse(hash['updated']['$t']),
        })
      end

      private
      def convert_from_response response
        JSON.parse(response)['feed']['entry'].map{|t| from_api(t) }
      end
    end
  end
end
