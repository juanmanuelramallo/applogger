FactoryBot.define do
  factory :log do
    priority { 100 }
    syslog_version { '1' }
    timestamp { Time.now }
    host { 'host' }
    app_name { 'myapp' }
    process_name { 'web.1' }
    message { 'Some message' }
  end
end
