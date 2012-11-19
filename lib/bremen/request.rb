require 'open-uri'
require 'cgi'

module Bremen
  module Request
    def get url
      open(url).read
    end

    def build_query options = {}
      options.to_a.map{|o| "#{o[0]}=#{CGI.escape(o[1].to_s)}" }.join('&')
    end
  end
end
