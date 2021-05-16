require 'rails_helper'

RSpec.describe 'Entries' do
  describe 'GET /entries' do
    subject { get entries_path, headers: basic_authorization_header }

    it 'renders entries' do
      create(:entry, user_agent: 'Safari')
      create(:entry, action_name: 'index', controller_name: 'testing')

      subject

      assert_select 'td', 'Safari'
      assert_select 'td', 'testing#index'
    end
  end
end
