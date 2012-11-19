$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Youtube do
  describe '.search_url' do
    subject{ Bremen::Youtube.search_url(params) }
    describe 'only keyword' do
      let(:params){ {keyword: 'searchword'} }
      it 'generate' do
        subject.must_equal 'http://gdata.youtube.com/feeds/api/videos/-/Music//?vq=searchword&orderby=published&max-results=25&alt=json'
      end
    end

    describe 'full params' do
      let(:params){ {keyword: 'searchword', order: 'relevance', limit: 1, category: 'Entertainment', tag: 'game'} }
      it 'generate' do
        subject.must_equal 'http://gdata.youtube.com/feeds/api/videos/-/Entertainment/game/?vq=searchword&orderby=relevance&max-results=1&alt=json'
      end
    end
  end

  describe '.convert_from_response' do
    subject{ Bremen::Youtube.send(:convert_from_response, response) }
    let(:response){ fixture('youtube.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
