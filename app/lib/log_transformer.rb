class LogTransformer
  TRANSFORMABLE_VALUES = [
    'path',
    'referrer',
    'query_string',
    'http_method',
    'format',
    'ip',
    'user_agent'
  ].freeze
  MATCHER_REGEXP = /#{ENV.fetch('LOG_LINE_KEY')}=(?<data>\{.+\})/

  attr_reader :log

  def initialize(log)
    @log = log
  end

  def call
    match_data = MATCHER_REGEXP.match(log.message)

    return {} if match_data.nil? || match_data[:data].empty?

    parsed_data = JSON.parse(match_data[:data])

    parsed_data.slice(*TRANSFORMABLE_VALUES).merge(
      'country_code' => IpTransformer.call(parsed_data['ip'])
    )
  end
end
