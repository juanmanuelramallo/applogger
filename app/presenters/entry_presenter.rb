class EntryPresenter
  include Presentable

  RSS_READERS = [
    'Spotify/1.0',
    'iTMS',
    'Jakarta Commons-HttpClient/3.1'
  ].freeze

  delegate :link_to, to: "ActionController::Base.helpers"
  delegate :logs_path, to: "Rails.application.routes.url_helpers"

  def rss_reader?
    RSS_READERS.include?(user_agent)
  end

  def browser
    @browser ||= Browser.new(user_agent)
  end

  def log_id
    link_to object.log_id, logs_path(id: object.log_id), class: "underline"
  end
end
