FactoryBot.define do
  factory :entry do
    action_name { 'show' }
    controller_name { 'podcasts' }
    format { 'application/rss+xml' }
    ip { '105.54.36.2' }
    country_code { 'BO' }
    user_agent { 'Spotify/1.0' }
    timestamp { Time.now }

    trait :with_log do
      log
    end
  end
end
