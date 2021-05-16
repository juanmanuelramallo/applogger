class LogTransformer
  TRANSFORMABLE_KEY = 'podcastfeeder-analytics'
  TRANSFORMABLE_VALUES = [
    'action_name',
    'controller_name',
    'format',
    'ip',
    ['ip', IpTransformer, 'country_code'],
    'user_agent'
  ].freeze
  MATCHER_REGEXP = /#{TRANSFORMABLE_KEY}=(?<data>\{.+\})/.freeze

  attr_reader :log

  def initialize(log)
    @log = log
  end

  def call
    match_data = MATCHER_REGEXP.match(log.message)

    return if match_data.nil? || match_data[:data].empty?

    parsed_data = JSON.parse(match_data[:data])
    Rails.logger.info parsed_data

    TRANSFORMABLE_VALUES.map do |value_name|
      transformer = nil
      destination_name = nil
      value_name, transformer, destination_name = value_name if value_name.is_a? Array

      value = parsed_data.fetch(value_name)
      value = transformer.call(value) if transformer.present?

      [destination_name || value_name, value]
    end.to_h
  end
end
