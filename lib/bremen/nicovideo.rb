require 'json'
require 'bremen/base'

module Bremen
  class Nicovideo < Bremen::Base
    BASE_URL = 'http://www.nicovideo.jp/'
    self.default_options = {
      keyword: '',
      page: 1,
      sort: 'f', #n(newer commented)/v(viewed)/r(most commented)/m(listed)/f(uploaded)/l(duration)
      order: 'd', #a(asc)/d(desc)
      within: '', #1(24h)/2(1w)/3(1m)
      length: '', #1(-5min)/2(20min-)
      downloadable: '', #1(music downloadable)
    }

    class << self
      def find_url uid_or_url
        unless uid_or_url.include?('www.nicovideo.jp')
          "#{BASE_URL}watch/#{uid_or_url}"
        else
          uid_or_url
        end
      end

      def search_url options = {}
        options = default_options.merge(options)
        query = {
          page: options[:page],
          sort: options[:sort],
          order: options[:order],
          f_range: options[:within],
          l_range: options[:length],
          opt_md: options[:downloadable],
        }
        "#{BASE_URL}search/#{CGI.escape(options[:keyword])}?#{build_query(query)}"
      end

      private
      def convert_singly response
        uid = response.scan(%r{<link rel="canonical" href="/watch/([^"]+)">}).flatten.first
        created_at = Time.parse(response.scan(%r{<meta property="video:release_date" content="(.+)">}).flatten.first.to_s).utc
        new({
          uid: uid,
          url: "#{BASE_URL}watch/#{uid}",
          title: CGI.unescape(response.scan(%r{<meta property="og:title" content="(.+)">}).flatten.first.to_s),
          author: Bremen::Author.new({
            name: response.scan(%r{<strong itemprop="name">(.+)</strong>}).flatten.first,
          }),
          length: response.scan(%r{<meta property="video:duration" content="(\d+)">}).flatten.first.to_i,
          thumbnail_url: response.scan(%r{<meta property="og:image" content="(.+)">}).flatten.first,
          created_at: created_at,
          updated_at: created_at,
        })
      end

      def convert_multiply response
        return [] if response.scan(%r{<div class="videoList01">}).flatten.first

        response.scan(%r{<li class="item" [^>]+ data-enable-uad="1">\n(.*?)\n    </li>}m).flatten.map do |html|
          uid = html.scan(%r{<div class="itemThumb" [^>]+ data-id="(.+)">}).flatten.first
          min, sec = html.scan(%r{<span class="videoLength">([\d:]+)</span></div>}).flatten.first.to_s.split(':')
          created_at = Time.parse(html.scan(%r{<span class="time">(.+:\d\d)</span>}).flatten.first.to_s.gsub(/\xE5\xB9\xB4|\xE6\x9C\x88|\xE6\x97\xA5/n, '')).utc
          new({
            uid: uid,
            url: "#{BASE_URL}watch/#{uid}",
            title: CGI.unescape(html.scan(%r{<p class="itemTitle">\n\s+<a [^>]+>(.+)</a>}).flatten.first.to_s),
            length: min.to_i * 60 + sec.to_i,
            thumbnail_url: html.scan(%r{<img [^>]+data-original="([^"]+)"[^>]*data-thumbnail [^>]+/?>}).flatten.first,
            created_at: created_at,
            updated_at: created_at,
          })
        end
      end
    end
  end
end
