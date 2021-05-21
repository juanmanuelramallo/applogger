class EntryPresenter
  include Presentable

  RSS_READERS = [
    'Spotify/1.0',
    'iTMS',
    'Jakarta Commons-HttpClient/3.1'
  ].freeze

  def rss_reader?
    RSS_READERS.include?(user_agent)
  end

  def browser
    @browser ||= Browser.new(user_agent)
  end
end
