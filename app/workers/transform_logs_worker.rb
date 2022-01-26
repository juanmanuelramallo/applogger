class TransformLogsWorker
  include Sidekiq::Worker

  def perform(log_ids)
    logs = Log.where(id: log_ids)
    return unless logs.any?

    logs.each do |log|
      next if log.entry.present?

      attributes = LogTransformer.new(log).call
      if attributes.present?
        Entry.create!(attributes.compact.merge(timestamp: log.timestamp, log_id: log.id))
      else
        log.destroy! unless Config.keep_logs?
      end
    end
  end
end
