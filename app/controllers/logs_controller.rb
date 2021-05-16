class LogsController < ApplicationController
  def index
    @pagy, @logs = pagy(Log.all.order(:timestamp))
  end

  def create
    parser = SyslogParser.new(message_count: message_count, body: request.body.read)

    Log.create(parser.parse)
  end

  private

  def message_count
    request.headers['Logplex-Msg-Count'].to_i
  end
end
