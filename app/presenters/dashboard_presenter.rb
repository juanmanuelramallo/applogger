class DashboardPresenter
  attr_reader :from_time, :to_time

  def initialize(from_time:, to_time:)
    @from_time = from_time
    @to_time = to_time
  end

  def user_agents
    entries.pluck(:user_agent).uniq.map do |user_agent|
      browser = Browser.new(user_agent)
      name = browser.unknown? ? user_agent : browser.name

      [name, user_agent]
    end.sort_by(&:first)
  end

  def paths
    entries.pluck(:path).uniq.sort
  end

  def country_codes
    entries.pluck(:country_code).uniq.sort
  end

  def request_formats
    entries.pluck(:format).uniq.sort
  end

  private

  def entries
    @entries ||= Entry.where(timestamp: from_time..to_time)
  end
end
