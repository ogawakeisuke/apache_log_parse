require "./apache_log"
require "./Entry"

DOWNLOADS_ROOT = "/Users/ogawa/Downloads/"

Dir.glob("#{DOWNLOADS_ROOT}log/access_lo*").sort.each_with_index do |f, i|
  File.foreach(f) do |line|
    entry = ApacheLog.parse(line.chomp)
    Entry.create!(
      :ip_address      => entry.ip_address,
      # :identity_check  => entry.identity_check,
      :user            => entry.user,
      :datetime        => entry.datetime,
      :request         => entry.request,
      :status          => entry.status,
      :size            => entry.size,
      :referer         => entry.referer,
      :user_agent      => entry.user_agent
    )
  end
end