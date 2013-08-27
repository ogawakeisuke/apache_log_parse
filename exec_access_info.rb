require "./apache_log"
require "./access_info"
require "pp"

request_hashes = Hash.new




def access_info_create(entry)
  AccessInfo.create(
    :url => entry.request[:path],
    :pv => 1,
    :uu => 1,
    :date_at => entry.datetime
  )
end


DOWNLOADS_ROOT = "/Users/ogawa/Downloads/"
Dir.glob("#{DOWNLOADS_ROOT}log/access_lo*").sort.each_with_index do |f, i|
  entries = []
  File.foreach(f) do |line|
    entries << ApacheLog.parse(line.chomp)
  end

  # TODO refactaring
  # wordpressなどの単語を除外
  # datetimeが同じものでgroup
  entries = entries.delete_if { |e| e.request[:path] =~ /wordpress/ }.group_by {|entry| entry.datetime.to_date }

  entries.each do |date_key, date_entries|
    entries[date_key] = date_entries.group_by {|e| e.request[:path] }
  end

  #
  # DBに書き込み
  #
  entries.each do |date_key, date_enies|
    date_enies.each do |url_key, url_entries|
      pv = url_entries.count
      uu = url_entries.collect {|entry| entry.ip_address }.uniq.count
      AccessInfo.create(
        :url => url_key,
        :pv => pv,
        :uu => uu,
        :date_at => date_key
        )
    end
  end
  
end