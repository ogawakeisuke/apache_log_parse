require "./apache_log"

request_hashes = Hash.new


Dir.glob("access_lo*").sort.each_with_index do |f, i|
  entries = []
  File.foreach(f) do |line|
    entries << ApaccheLog.parse(line.chomp)
  end

  request_paths = entries.collect { |e| e.request[:path] }

  request_paths.each do |req_path|
    unless request_hashes.has_key?(req_path)
      request_hashes[req_path] = 1
    else
      request_hashes[req_path] += 1
    end
  end

end



File.open("out.txt", "w") do |io|
  request_hashes.each_pair do |k,v|
    io.puts  "#{k} = #{v}"
  end
end