require 'rails_helper'

RSpec.describe TransformLogsWorker, type: :worker do
  describe '#perform' do
    subject { described_class.perform_async(log_ids) }

    let(:log_ids) { logs.map(&:id) }
    let(:entry) { create(:entry) }
    let(:logs) do
      [
        create(:log, message: 'I, [2021-05-15T23:56:26.706865 #4] INFO -- : '\
               '[10f6cec9-3d36-4521-b304-562baffdfc72] podcastfeeder-analytics='\
               '{"path":"/podcasts","http_method":"GET","query_string":"","referrer":"","format":'\
               '"application/rss+xml","ip":"34.77.30.1","user_agent":"Spotify/1.0"}'),
        create(:log, message: 'This log will be removed'),
        create(:log, message: 'I, [2021-05-15T23:56:26.706865 #4] INFO -- : '\
               '[10f6cec9-3d36-4521-b304-562baffdfc72] podcastfeeder-analytics='\
               '{"path":"/podcasts","http_method":"GET","query_string":"","referrer":null,"format":'\
               '"application/rss+xml","ip":"34.77.30.1","user_agent":"Spotify/1.0"}'),
        entry.log
      ]
    end

    it 'creates two entries' do
      logs

      expect { subject }.to change { Entry.count }.by(2)
    end

    it 'removes unprocessed logs' do
      logs

      expect { subject }.to change { Log.count }.by(-1)
    end
  end
end
