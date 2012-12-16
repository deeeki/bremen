module Bremen
  class Author
    attr_accessor :uid, :url, :name, :thumbnail_url

    def initialize attrs = {}
      attrs.each do |key, value|
        send("#{key}=", value) if respond_to?(key)
      end
    end
  end
end
