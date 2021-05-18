class Calculator
  attr_reader :from_date, :to_date

  def initialize(from_date:, to_date:)
    @from_date = from_date
    @to_date = to_date
  end

  def count
    @count ||= entries.count
  end

  def countries_count
    @countries_count ||= entries.pluck(:country_code).uniq.size
  end

  def path_count
    @path_count ||= entries.pluck(:action_name, :controller_name).uniq.size
  end

  private

  def entries
    Entry.where(timestamp: from_date..to_date)
  end
end
