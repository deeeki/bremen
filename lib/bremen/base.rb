require 'bremen/track'
require 'bremen/request'

module Bremen
  class Base
    include Track
    extend Request

    class << self
      attr_accessor :default_options

      def find options = {}
        convert_from_response(get(search_url(options)))
      end

      #abstract methods
      def search_url options = {}; end
      private
      def convert_from_response response; end
    end
  end
end
