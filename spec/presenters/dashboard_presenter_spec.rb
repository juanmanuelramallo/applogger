require 'rails_helper'

RSpec.describe DashboardPresenter do
  let(:presenter) { described_class.new(from_time: from_time, to_time: to_time) }
  let(:from_time) { Time.now - 1.day }
  let(:to_time) { Time.now }

  before do
    create(:entry, timestamp: Time.now - 2.days)
    create(:entry, timestamp: Time.now - 12.hours, user_agent: 'iTMS', path: '/podcasts', country_code: 'CO')
    create(:entry, timestamp: Time.now - 30.minutes, user_agent: 'iTMS', path: '/user/2', country_code: 'BO')
  end

  describe '#user_agents' do
    subject { presenter.user_agents }

    it { is_expected.to contain_exactly('iTMS') }
  end

  describe '#paths' do
    subject { presenter.paths }

    it { is_expected.to contain_exactly('/podcasts', '/user/2') }
  end

  describe '#country_codes' do
    subject { presenter.country_codes }

    it { is_expected.to contain_exactly('CO', 'BO') }
  end
end
