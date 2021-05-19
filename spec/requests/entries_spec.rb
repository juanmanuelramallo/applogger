require 'rails_helper'

RSpec.describe 'Entries' do
  describe 'GET /entries' do
    subject { get entries_path, headers: basic_authorization_header }

    it 'renders entries' do
      create(:entry, user_agent: 'Safari')
      create(:entry, path: '/index')

      subject

      assert_select 'td', 'Safari'
      assert_select 'td', '/index'
    end
  end
end
