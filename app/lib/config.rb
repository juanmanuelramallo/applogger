class Config
  class << self
    def keep_logs?
      ENV.fetch("CONFIG_KEEP_LOGS", "false") == "true"
    end
  end
end
