FactoryBot.define do
  factory :entry do
    path { '/' }
    query_string { 'test=yes' }
    referrer { '' }
    http_method { 'GET' }
    format { 'application/rss+xml' }
    ip { '105.54.36.2' }
    country_code { 'BO' }
    user_agent { 'Spotify/1.0' }
    timestamp { Time.now }
    log
  end
end
