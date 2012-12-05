$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Mixcloud do
  describe '.find_url' do
    subject{ Bremen::Mixcloud.find_url(uid_or_url) }
    describe 'given id' do
      let(:uid_or_url){ '/author/permalink/' }
      it 'generate' do
        subject.must_equal 'http://api.mixcloud.com/author/permalink/'
      end
    end

    describe 'given url' do
      let(:uid_or_url){ 'http://www.mixcloud.com/author/permalink/' }
      it 'generate' do
        subject.must_equal 'http://api.mixcloud.com/author/permalink/'
      end
    end
  end

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

  describe '.convert_singly' do
    subject{ Bremen::Mixcloud.send(:convert_singly, response) }
    let(:response){ fixture('mixcloud_single.json') }
    it 'convert successfully' do
      subject.title.must_equal 'Title'
    end
  end

  describe '.convert_multiply' do
    subject{ Bremen::Mixcloud.send(:convert_multiply, response) }
    let(:response){ fixture('mixcloud_multi.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
