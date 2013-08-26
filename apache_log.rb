require "date"
class ApacheLog
  attr_reader :ip_address, :identity_check, :user, :datetime, :request, :status, :size, :referer, :user_agent

   def initialize(args)
    @ip_address     = args[:ip_address]
    @identity_check = args[:identity_check]
    @user           = args[:user]
    @datetime       = args[:datetime]
    @request        = args[:request]
    @status         = args[:status]
    @size           = args[:size]
    @referer        = args[:referer]
    @user_agent     = args[:user_agent]
  end


  def self.parse(line)
    match = line.match(log_pattern) 
    p match
    captures = match.captures

    self.new(
      :ip_address      => captures[0],
      :identity_check  => captures[1],
      :user            => captures[2],
      :datetime        => parse_datetime(captures[3]),
      :request         => parse_request(captures[4]),
      :status          => captures[5],
      :size            => captures[6],
      :referer         => captures[7],
      :user_agent      => captures[8],
      )
  end


  def self.parse_datetime(str)
    DateTime.strptime( str, '%d/%b/%Y:%T %z')
  end

  def self.parse_request(str)
    method, path, protocol = str.split
    {
      :method   => method,
      :path     => path,
      :protocol => protocol 
    }
  end


  def self.log_pattern
    /
      ^
      (\S+)       
      \s+
      (\S+)       
      \s+
      (\S+)
      \s+
      \[ (.*?) \]
      \s+
      " (.*?) "
      \s+
      (\S+)
      \s+
      (\S+)
      \s+
      " (.*?) "
      \s+
      " (.*?) "
      $
    /x
  end
end