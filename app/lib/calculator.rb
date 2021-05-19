class Calculator
  MAX_PERIOD_IN_DAYS = 90

  attr_reader :from_time, :to_time

  def initialize(from_time:, to_time:)
    @from_time = from_time
    @to_time = to_time

    if (to_time.to_date - from_time.to_date).to_i > MAX_PERIOD_IN_DAYS
      @from_time = to_time - 1.week
    end
  end

  def count
    @count ||= entries.count
  end

  def countries_count
    @countries_count ||= entries.pluck(:country_code).uniq.size
  end

  def path_count
    @path_count ||= entries.pluck(:path).uniq.size
  end

  def browsers_count
    @browsers_count ||= entries.pluck(:user_agent).uniq.size
  end

  def entries_count_by_day
    entries.group_by_day(:timestamp).count
  end

  def entries_count_by_country
    entries.group(:country_code).count
  end

  private

  def entries
    Entry.where(timestamp: from_time..to_time)
  end
end
