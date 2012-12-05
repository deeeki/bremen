$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Youtube do
  describe '.find_url' do
    subject{ Bremen::Youtube.find_url(uid_or_url) }
    describe 'given id' do
      let(:uid_or_url){ 'XXXXXXXXXXX' }
      it 'generate' do
        subject.must_equal 'http://gdata.youtube.com/feeds/api/videos/XXXXXXXXXXX?alt=json'
      end
    end

    describe 'given url' do
      let(:uid_or_url){ 'http://www.youtube.com/watch?v=XXXXXXXXXXX' }
      it 'generate' do
        subject.must_equal 'http://gdata.youtube.com/feeds/api/videos/XXXXXXXXXXX?alt=json'
      end
    end
  end

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

  describe '.convert_singly' do
    subject{ Bremen::Youtube.send(:convert_singly, response) }
    let(:response){ fixture('youtube_single.json') }
    it 'convert successfully' do
      subject.title.must_equal 'Title'
    end
  end

  describe '.convert_multiply' do
    subject{ Bremen::Youtube.send(:convert_multiply, response) }
    let(:response){ fixture('youtube_multi.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
