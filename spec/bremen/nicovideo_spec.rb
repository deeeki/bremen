$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Nicovideo do
  describe '.find_url' do
    subject{ Bremen::Nicovideo.find_url(uid_or_url) }
    describe 'given id' do
      let(:uid_or_url){ 'sm1111111' }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/watch/sm1111111'
      end
    end

    describe 'given url' do
      let(:uid_or_url){ 'http://www.nicovideo.jp/watch/sm1111111' }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/watch/sm1111111'
      end
    end
  end

  describe '.search_url' do
    subject{ Bremen::Nicovideo.search_url(params) }
    describe 'only keyword' do
      let(:params){ {keyword: 'searchword'} }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/search/searchword?page=1&sort=f&order=d&f_range=&l_range=&opt_md='
      end
    end

    describe 'full params' do
      let(:params){ {keyword: 'searchword', page: 2, sort: 'n', order: 'a', within: 3, length: 2, downloadable: 1} }
      it 'generate' do
        subject.must_equal 'http://www.nicovideo.jp/search/searchword?page=2&sort=n&order=a&f_range=3&l_range=2&opt_md=1'
      end
    end
  end

  describe '.convert_singly' do
    subject{ Bremen::Nicovideo.send(:convert_singly, response) }
    let(:response){ fixture('nicovideo_single.html') }
    it 'convert successfully' do
      subject.title.must_equal 'Title'
      subject.created_at.zone.must_equal 'UTC'
    end
  end

  describe '.convert_multiply' do
    subject{ Bremen::Nicovideo.send(:convert_multiply, response) }
    let(:response){ fixture('nicovideo_multi.html') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
      subject.first.created_at.zone.must_equal 'UTC'
    end
  end
end
