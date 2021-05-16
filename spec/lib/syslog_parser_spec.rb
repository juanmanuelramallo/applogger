require 'rails_helper'

RSpec.describe SyslogParser do
  describe '#parse' do
    let(:parser) { described_class.new(message_count: message_count, body: body) }
    subject { parser.parse }

    let(:message_count) { 3 }
    let(:body) do
      "83 <40>1 2012-11-30T06:45:29+00:00 host app web.3 - State changed from starting to up\n"\
      "119 <40>1 2012-11-30T06:45:26+00:00 host app web.3 - Starting process with command `bundle exec rackup config.ru -p 24405`\n"\
      "85 <41>1 2012-11-30T06:45:29+00:00 host myapp web.1 - State changed from starting to up\n"
    end

    it 'returns an array of hashes' do
      expect(subject).to be_instance_of(Array)
      expect(subject).to all(be_instance_of(Hash))
    end

    it 'returns correct parsed information' do
      expect(subject).to contain_exactly(
        include(
          'priority' => '40',
          'syslog_version' => '1',
          'timestamp' => '2012-11-30T06:45:29+00:00',
          'host' => 'host',
          'app_name' => 'app',
          'process_name' => 'web.3',
          'message' => 'State changed from starting to up'
        ),
        include(
          'priority' => '40',
          'syslog_version' => '1',
          'timestamp' => '2012-11-30T06:45:26+00:00',
          'host' => 'host',
          'app_name' => 'app',
          'process_name' => 'web.3',
          'message' => 'Starting process with command `bundle exec rackup config.ru -p 24405`'
        ),
        include(
          'priority' => '41',
          'syslog_version' => '1',
          'timestamp' => '2012-11-30T06:45:29+00:00',
          'host' => 'host',
          'app_name' => 'myapp',
          'process_name' => 'web.1',
          'message' => 'State changed from starting to up'
        )
      )
    end

    context 'when message count is overvalued' do
      let(:message_count) { 4 }

      it 'returns an empty array and provides errors' do
        expect(subject).to eq []
        expect(parser.errors[:message_count]).to be_present
      end
    end

    context 'when message count is undervalued' do
      let(:message_count) { 2 }

      it 'returns an empty array and provides errors' do
        expect(subject).to eq []
        expect(parser.errors[:message_count]).to be_present
      end
    end
  end
end
