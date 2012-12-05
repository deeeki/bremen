require 'bremen/track'
require 'bremen/request'

module Bremen
  class Base
    include Track
    extend Request

    class << self
      attr_accessor :default_options

      def find uid_or_url
        convert_singly(get(find_url(uid_or_url)))
      end

      def search options = {}
        convert_multiply(get(search_url(options)))
      end

      #abstract methods
      def find_url uid_or_url; end
      def search_url options = {}; end
      private
      def convert_singly response; end
      def convert_multiply response; end
    end
  end
end
