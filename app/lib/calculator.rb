class Calculator
  attr_reader :entries

  # @param entries [Entry::ActiveRecord_Relation]
  def initialize(entries)
    @entries = entries
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
end
