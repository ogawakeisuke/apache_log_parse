require "./apache_log"
require "./access_info"

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



Dir.glob("access_lo*").sort.each_with_index do |f, i|
  entries = Array.new().collect { Array.new }
  entries_count = 0

  File.foreach(f) do |line|
    a = ApaccheLog.parse(line.chomp)
    entries[entries_count] <<  a
    entries_count += 1 unless a.datetime == entries.last.datetime
  end
 
end



# File.open("out.txt", "w") do |io|
#   request_hashes.each_pair do |k,v|
#     io.puts  "#{k} = #{v}"
#   end
# end