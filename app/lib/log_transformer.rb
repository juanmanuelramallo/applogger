class LogTransformer
  TRANSFORMABLE_KEY = 'podcastfeeder-analytics'
  TRANSFORMABLE_VALUES = [
    'action_name',
    'controller_name',
    'format',
    'ip',
    'user_agent'
  ].freeze
  MATCHER_REGEXP = /#{TRANSFORMABLE_KEY}=(?<data>\{.+\})/.freeze

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
