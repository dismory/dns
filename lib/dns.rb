def main(argv)
  if argv.empty?
    get_dns
    exit
  end

  case argv.first

  when 'list'
    res = `networksetup -listallnetworkservices`
    res_copy = res.dup
    res_copy.prepend "# Network Services:\n"
    res_copy = res_copy.split("\n").map.with_index do |name, index|
      if index > 1
        "- #{name}"
      else
        name
      end
    end.join("\n")
    puts res_copy

  when 'flush'
    flush_dns

  when 'default'
    set_dns
  when 'google'
    set_dns(dns: '8.8.8.8')
  when 'opendns'
    set_dns(dns: ['208.67.222.222', '208.67.220.220'])

  when 'get'
    case argv[1]
    when nil
      get_dns
    when 'all'
      res = `networksetup -listallnetworkservices`
      services = res.split("\n")
      services.delete_at(0) # remove this line 'An asterisk (*) denotes that a network service is disabled.'
      puts "# Network Services DNS:"
      services.each do |service|
        get_dns(service)
      end
    end

  else
    usage
  end
end

def get_dns(name = 'Wi-Fi')
  puts "- #{name} DNS:"
  res = `networksetup -getdnsservers "#{name}"`.split("\n").map { |dns| dns.prepend("\t") }.join("\n")
  puts res
end

def set_dns(options = {})
  case options[:name]
  when String
  when nil
    options[:name] = 'Wi-Fi'
  else
    raise ArgumentError, 'invalid argument'
  end

  case options[:dns]
  when Array
  when String
    options[:dns] = [options[:dns]]
  when nil
    options[:dns] = ['EMPTY']
  else
    raise ArgumentError, 'invalid argument'
  end

  cmd = 'networksetup', '-setdnsservers', options[:name]
  cmd += options[:dns]
  system cmd.join(' ')

  puts "Set #{options[:name]} DNS to #{options[:dns].join(', ')} successfully!"
end

def flush_dns
  system('dscacheutil -flushcache; sudo killall -HUP mDNSResponder;')
end

def usage
  puts <<-USAGE
  - dns         :show Wi-Fi DNS servers

  - dns list    :show all network services

  - dns get     :show Wi-Fi DNS servers
  - dns get all :show all DNS servers

  - dns defalut :remove Wi-Fi DNS servers
  - dns opendns :set Wi-Fi DNS servers to OpenDNS(208.67.222.222, 208.67.220.220)
  - dns google  :set Wi-Fi DNS servers to Google(8.8.8.8)

  - dns flush   :flush DNS cache
  USAGE
end
