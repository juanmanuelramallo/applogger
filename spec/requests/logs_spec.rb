require 'rails_helper'

RSpec.describe 'Logs' do
  describe 'GET /logs' do
    subject { get logs_path, headers: basic_authorization_header }

    it 'renders a collection of logs' do
      create(:log, message: 'Logging a message')
      create(:log, message: 'Another message')
      subject

      assert_select 'span[title="Message"]', 'Logging a message'
      assert_select 'span[title="Message"]', 'Another message'
    end

    it "render a log when filtering by id" do
      log = create(:log, message: 'Single log')
      create(:log, message: 'Another message')
      get logs_path, params: {id: log.id}, headers: basic_authorization_header

      assert_select 'span[title="Message"]', 'Single log'
      assert_select 'span[title="Message"]', text: 'Another message', count: 0
    end

    it "renders a message if there are no logs" do
      subject

      assert_select 'p', 'No logs found.'
    end
  end

  describe 'POST /logs' do
    subject { post logs_path, params: body, headers: basic_authorization_header.merge('Logplex-Msg-Count': 2), as: :raw }

    let(:body) do
      "83 <40>1 2012-11-30T06:45:29+00:00 host app web.3 - State changed from starting to up\n"\
      "119 <40>1 2012-11-30T06:45:26+00:00 host app web.3 - Starting process with command `bundle exec rackup config.ru -p 24405`\n"
    end

    it 'creates two logs' do
      expect { subject }.to change { Log.count }.by(2)
    end

    it 'enques a job to transform the logs' do
      expect { subject }.to change { TransformLogsWorker.jobs.size }.by(1)
    end
  end
end
