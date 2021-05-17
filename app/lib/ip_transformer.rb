class IpTransformer
  attr_reader :ip

  def self.call(ip)
    new(ip).call
  end

  def initialize(ip)
    @ip = ip
  end

  def call
    record = ip_database.lookup(ip)
    return '' unless record.found?

    record.country.iso_code
  end

  private

  def ip_database
    MaxMindDB.new(
      File.join(
        ENV.fetch('GEOIP_GEOLITE2_PATH'),
        ENV.fetch('GEOIP_GEOLITE2_COUNTRY_FILENAME')
      ), MaxMindDB::LOW_MEMORY_FILE_READER
    )
  end
end
