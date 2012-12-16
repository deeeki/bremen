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
      def build_query options = {}
        super(options.merge(alt: 'json'))
      end

      def find_url uid_or_url
        uid = uid_or_url.scan(%r{[?&]v=(.{11})}).flatten.first || uid_or_url
        "#{BASE_URL}#{uid}?#{build_query}"
      end

      def search_url options = {}
        options = default_options.merge(options)
        query = {
          vq: options[:keyword],
          orderby: options[:order],
          :"max-results" => options[:limit],
        }
        "#{BASE_URL}-/#{options[:category]}/#{options[:tag]}/?#{build_query(query)}"
      end

      def from_api hash = {}
        uid = hash['id']['$t'].sub('http://gdata.youtube.com/feeds/api/videos/', '')
        author = hash['author'].first
        new({
          uid: uid,
          url: "http://www.youtube.com/watch?v=#{uid}",
          title: hash['title']['$t'],
          author: Bremen::Author.new({
            uid: author.key?('yt$userId') ? author['yt$userId']['$t'] : nil,
            url: author['uri']['$t'].sub('gdata.youtube.com/feeds/api/users/', 'www.youtube.com/channel/UC'),
            name: author['name']['$t'],
          }),
          length: hash['media$group']['yt$duration']['seconds'].to_i,
          thumbnail_url: hash['media$group']['media$thumbnail'][0]['url'],
          created_at: Time.parse(hash['published']['$t']),
          updated_at: Time.parse(hash['updated']['$t']),
        })
      end

      private
      def convert_singly response
        from_api(JSON.parse(response)['entry'])
      end

      def convert_multiply response
        JSON.parse(response)['feed']['entry'].map{|t| from_api(t) }
      end
    end
  end
end
