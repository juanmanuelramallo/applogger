class SyslogParser
  attr_reader :message_count, :body, :errors

  # Each named capture correlates to a column in the +logs+ table
  FRAME_REGEX = Regexp.new [
    '<(?<priority>\d+)>',
    '(?<syslog_version>\d) ',
    '(?<timestamp>\S+) ',
    '(?<host>\S+) ',
    '(?<app_name>\S+) ',
    '(?<process_name>\S+) ',
    '- (?<message>.+)'
  ].join.freeze

  def initialize(message_count:, body:)
    @message_count = message_count
    @body = body
    @errors = {}
  end

  def parse
    body_index = 0
    parsed_logs = message_count.times.map do |index|
      # Overflow error
      if body_index >= body.size
        errors[:message_count] = "with #{message_count} is inconsistent with body, overflowed body."
        return []
      end

      # Get frame size
      frame = /\A(\d)+/.match(body[body_index..])[0].to_i

      # Discard frame information and whitespace
      body_index += frame.to_s.size + 1

      # Get current frame
      current_frame = body[body_index..(body_index + frame)]

      # Advance pointer to the next frame
      body_index += frame

      FRAME_REGEX.match(current_frame).named_captures
    end

    # Missing frames to parse
    if body_index != body.size
      errors[:message_count] = "with #{message_count} is inconsistent with body, missing frames to parse."
      return []
    end

    parsed_logs
  end
end
