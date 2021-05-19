require 'rails_helper'

RSpec.describe LogTransformer do
  describe '#call' do
    subject { described_class.new(log).call }

    let(:log) do
      create(:log, message: 'I, [2021-05-15T23:56:26.706865 #4] INFO -- : '\
             '[10f6cec9-3d36-4521-b304-562baffdfc72] podcastfeeder-analytics='\
             '{"path":"/podcasts","http_method":"GET","query_string":"","referrer":"","format":'\
             '"application/rss+xml","ip":"34.77.30.1","user_agent":"Spotify/1.0"}')
    end

    it 'returns a hash' do
      expect(subject).to be_instance_of(Hash)
    end

    it 'extracts and transforms with the correct values' do
      expect(subject).to include(
        'path' => '/podcasts',
        'http_method' => 'GET',
        'country_code' => 'BE',
        'format' => 'application/rss+xml',
        'ip' => '34.77.30.1',
        'user_agent' => 'Spotify/1.0',
        'query_string' => '',
        'referrer' => ''
      )
    end
  end
end
