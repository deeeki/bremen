require 'json'
require 'bremen/base'

module Bremen
  class Nicovideo < Bremen::Base
    BASE_URL = 'http://www.nicovideo.jp/'
    self.default_options = {
      keyword: '',
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
        created_at = Time.parse(response.scan(%r{<meta property="video:release_date" content="(.+)">}).flatten.first.to_s)
        new({
          uid: uid,
          url: "#{BASE_URL}watch/#{uid}",
          title: CGI.unescape(response.scan(%r{<meta property="og:title" content="(.+)">}).flatten.first.to_s),
          length: response.scan(%r{<meta property="video:duration" content="(\d+)">}).flatten.first.to_i,
          thumbnail_url: response.scan(%r{<meta property="og:image" content="(.+)">}).flatten.first,
          created_at: created_at,
          updated_at: created_at,
        })
      end

      def convert_multiply response
        response.scan(%r{<div class="thumb_col_1">\n<!---->\n(.*?)\n<!---->\n</div></div>}m).flatten.map do |html|
          uid = html.scan(%r{<table [^>]+ summary="(.+)">}).flatten.first
          min, sec = html.scan(%r{<p class="vinfo_length"><span>([\d:]+)</span></p>}).flatten.first.to_s.split(':')
          created_at = Time.parse(html.scan(%r{<strong>(.+:\d\d)</strong>}).flatten.first.to_s.gsub(/\xE5\xB9\xB4|\xE6\x9C\x88|\xE6\x97\xA5/, ''))
          new({
            uid: uid,
            url: "#{BASE_URL}watch/#{uid}",
            title: CGI.unescape(html.scan(%r{<a [^>]+ class="watch" [^>]+>(.+)</a>}).flatten.first.to_s),
            length: min.to_i * 60 + sec.to_i,
            thumbnail_url: html.scan(%r{<img src="([^"]+)"[^>]*class="img_std96" ?/?>}).flatten.first,
            created_at: created_at,
            updated_at: created_at,
          })
        end
      end
    end
  end
end
