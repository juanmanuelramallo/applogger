FactoryBot.define do
  factory :log do
    priority { 100 }
    syslog_version { '1' }
    timestamp { Time.now }
    host { 'host' }
    app_name { 'myapp' }
    process_name { ['web.1', 'web.2', 'worker.1', 'worker.2'].sample }
    message { Faker::Lorem.paragraph(sentence_count: rand(4..12)) }
  end
end
