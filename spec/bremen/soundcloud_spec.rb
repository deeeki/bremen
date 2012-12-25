$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

describe Bremen::Soundcloud do
  describe '.build_query' do
    describe 'not set client_id' do
      it 'raise error' do
        lambda{ Bremen::Soundcloud.search_url }.must_raise RuntimeError
      end
    end

    describe 'set client_id' do
      before{ Bremen::Soundcloud.client_id = 'CID' }
      subject{ Bremen::Soundcloud.build_query({a: 'b'}) }
      it 'return query string' do
        subject.must_equal 'a=b&client_id=CID'
      end
    end
  end

  describe '.find_url' do
    before{ Bremen::Soundcloud.client_id = 'CID' }
    subject{ Bremen::Soundcloud.find_url(uid_or_url) }
    describe 'given id' do
      let(:uid_or_url){ 100 }
      it 'generate directly' do
        subject.must_equal 'http://api.soundcloud.com/tracks/100.json?client_id=CID'
      end
    end

    describe 'given url' do
      let(:uid_or_url){ 'http://soundcloud.com/author/permalink' }
      it 'generate with resolve resource' do
        subject.must_equal 'http://api.soundcloud.com/resolve.json?url=http%3A%2F%2Fsoundcloud.com%2Fauthor%2Fpermalink&client_id=CID'
      end
    end
  end

  describe '.search_url' do
    before{ Bremen::Soundcloud.client_id = 'CID' }
    subject{ Bremen::Soundcloud.search_url(params) }
    describe 'only keyword' do
      let(:params){ {keyword: 'searchword'} }
      it 'generate' do
        subject.must_equal 'http://api.soundcloud.com/tracks.json?q=searchword&order=created_at&limit=50&offset=0&filter=&client_id=CID'
      end
    end

    describe 'full params' do
      let(:params){ {keyword: 'searchword', order: 'hotness', limit: 10, page: 2, filter: 'public'} }
      it 'generate' do
        subject.must_equal 'http://api.soundcloud.com/tracks.json?q=searchword&order=hotness&limit=10&offset=10&filter=public&client_id=CID'
      end
    end
  end

  describe '.convert_singly' do
    subject{ Bremen::Soundcloud.send(:convert_singly, response) }
    let(:response){ fixture('soundcloud_single.json') }
    it 'convert successfully' do
      subject.title.must_equal 'Title'
      subject.uid.must_equal '11111111'
      subject.created_at.zone.must_equal 'UTC'
    end
  end

  describe '.convert_multiply' do
    subject{ Bremen::Soundcloud.send(:convert_multiply, response) }
    let(:response){ fixture('soundcloud_multi.json') }
    it 'convert successfully' do
      subject.first.title.must_equal 'Title'
      subject.first.uid.must_equal '11111111'
      subject.first.created_at.zone.must_equal 'UTC'
    end
  end
end
