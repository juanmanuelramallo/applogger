class LogsController < ApplicationController
  def create
    parsed_logs = SyslogParser.new(message_count: message_count, body: request.body.read).parse

    Log.create(parsed_logs)
  end

  private

  def message_count
    request.headers['Logplex-Msg-Count'].to_i
  end
end
