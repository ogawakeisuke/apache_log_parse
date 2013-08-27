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


def update_pv_and_uu(entry)
  entry.update(:pv => (entry.pv) + 1, :uu => (entry.pv) + 1)
end

def update_pv(entry)
  entry.update(:pv => (entry.pv) + 1)
end



# def reprace_process(entry)
#   ai = AccessInfo.where(:url => entry.request[:path])
#   if ai.first && 

#   end
# end


# DOWNLOADS_ROOT = "/Users/ogawa/Downloads/"
# Dir.glob("#{DOWNLOADS_ROOT}log/access_lo*")

Dir.glob("access_lo*").sort.each_with_index do |f, i|
  entries = []
  File.foreach(f) do |line|
    entries << ApacheLog.parse(line.chomp)
  end

  # TODO refactaring
  # wordpressなどの単語を除外
  # datetimeが同じものでgroup
  entries = entries.delete_if { |e| e.request[:path] =~ /wordpress/ }.group_by {|entry| entry.datetime.to_date }

  entries.each do |date_key, entry_collection|
    entries[date_key] = entry_collection.group_by {|e| e.request[:path] }
  end
  pp entries

end



# File.open("out.txt", "w") do |io|
#   request_hashes.each_pair do |k,v|
#     io.puts  "#{k} = #{v}"
#   end
# end