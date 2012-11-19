$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Nicovideo do
  describe '.search_url' do
    subject{ Bremen::Nicovideo.search_url(params) }
    describe 'only keyword' do
      let(:params){ {keyword: 'searchword'} }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/search/searchword?sort=f&order=d&f_range=&l_range=&opt_md='
      end
    end

    describe 'full params' do
      let(:params){ {keyword: 'searchword', sort: 'n', order: 'a', within: 3, length: 2, downloadable: 1} }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/search/searchword?sort=n&order=a&f_range=3&l_range=2&opt_md=1'
      end
    end
  end

  describe '.convert_from_response' do
    subject{ Bremen::Nicovideo.send(:convert_from_response, response) }
    let(:response){ fixture('nicovideo.html') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
    end
  end
end
