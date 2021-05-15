class SyslogParser
  attr_reader :message_count, :body

  # Each named capture correlated to a column in the +logs+ table
  FRAME_REGEX = Regexp.new [
    '<(?<priority>\d+)>',
    '(?<syslog_version>\d) ',
    '(?<timestamp>\S+) ',
    '(?<host>\S+) ',
    '(?<app_name>\S+) ',
    '(?<process_name>\S+) ',
    '- (?<message>.+)'
  ].join

  def initialize(message_count:, body:)
    @message_count = message_count
    @body = body
  end

  def parse
    body_index = 0
    message_count.times.map do |index|
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
  end
end
