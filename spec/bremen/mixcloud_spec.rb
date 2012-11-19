$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Mixcloud do
  describe '.search_url' do
    subject{ Bremen::Mixcloud.search_url(params) }
    describe 'only keyword' do
      let(:params){ {keyword: 'searchword'} }
      it 'generate' do
        subject.must_equal 'http://api.mixcloud.com/search/?q=searchword&limit=20&type=cloudcast'
      end
    end

    describe 'full params' do
      let(:params){ {keyword: 'searchword', limit: 1} }
      it 'generate' do
        subject.must_equal 'http://api.mixcloud.com/search/?q=searchword&limit=1&type=cloudcast'
      end
    end
  end

  describe '.convert_from_response' do
    subject{ Bremen::Mixcloud.send(:convert_from_response, response) }
    let(:response){ fixture('mixcloud.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
