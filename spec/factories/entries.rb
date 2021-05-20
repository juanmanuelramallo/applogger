FactoryBot.define do
  factory :entry do
    path { "/#{Faker::Internet.slug}" }
    query_string { 'test=yes' }
    referrer { Faker::Internet.url }
    http_method { ['GET', 'POST', 'PUT'].sample }
    format { ['application/rss+xml', 'text/html', 'text/javascript', 'application/csv', 'text/css'].sample }
    ip { Faker::Internet.public_ip_v4_address }
    country_code { Faker::Address.country_code }
    user_agent { Faker::Internet.user_agent }
    timestamp { Faker::Time.between(from: Time.now - 3.months, to: Time.now) }
    log
  end
end
