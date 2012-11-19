$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Soundcloud do
  describe '.search_url' do
    describe 'not set consumer_key' do
      it 'raise error' do
        lambda{ Bremen::Soundcloud.search_url }.must_raise RuntimeError
      end
    end
    describe 'set consumer_key' do
      before{ Bremen::Soundcloud.consumer_key = 'CK' }
      subject{ Bremen::Soundcloud.search_url(params) }
      describe 'only keyword' do
        let(:params){ {keyword: 'searchword'} }
        it 'generate' do
          subject.must_equal 'http://api.soundcloud.com/tracks.json?q=searchword&order=created_at&limit=50&filter=&consumer_key=CK'
        end
      end

      describe 'full params' do
        let(:params){ {keyword: 'searchword', order: 'hotness', limit: 1, filter: 'public'} }
        it 'generate' do
          subject.must_equal 'http://api.soundcloud.com/tracks.json?q=searchword&order=hotness&limit=1&filter=public&consumer_key=CK'
        end
      end
    end
  end

  describe '.convert_from_response' do
    subject{ Bremen::Soundcloud.send(:convert_from_response, response) }
    let(:response){ fixture('soundcloud.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
