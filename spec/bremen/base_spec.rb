$:.unshift(File.expand_path('../../', __FILE__))
require 'spec_helper'

envfile = File.expand_path('../../../.env', __FILE__)
if File.exists?(envfile)
  File.open(envfile, 'r').each do |line|
    key, val = line.chomp.split('=', 2)
    ENV[key] = val
  end
end
SITES = ['Youtube', 'Mixcloud', 'Nicovideo']
SITES << 'Soundcloud' if ENV['SOUNDCLOUD_CLIENT_ID']

describe Bremen::Base do
  describe '.search' do
    SITES.each do |site|
      describe site do
        let(:klass){ Bremen.const_get(site) }

        describe 'pagination' do
          let(:params){ {keyword: 'kyary pamyu pamyu', limit: 1} }
          let(:track_page1){ klass.search(params.merge(page: 1)).first }
          let(:track_page2){ klass.search(params.merge(page: 2)).first }
          it 'first tracks on each pages are different' do
            track_page1.uid.wont_equal track_page2.uid
          end
        end

        describe 'no result keyword' do
          let(:params){ {keyword: 'kyarolinecharonpropkyarypamyupamyu', limit: 1 } }
          subject{ klass.search(params) }
          it 'returns empty array' do
            subject.must_be_empty
          end
        end
      end
    end
  end
end
