class LogsController < ApplicationController
  def index
    @logs = Log.all.order(timestamp: :desc)
    @logs = @logs.where(id: params[:id]) if params[:id].present?
    @pagy, @logs = pagy(@logs)
  end

  def create
    parser = SyslogParser::Parser.new(message_count: message_count, body: request.body.read)

    logs = Log.create(parser.parse)

    TransformLogsWorker.perform_async(logs.map(&:id))
  end

  private

  def message_count
    request.headers['Logplex-Msg-Count'].to_i
  end
end
