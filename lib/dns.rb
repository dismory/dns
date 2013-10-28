require "yaml"


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
  ret = system cmd.join(' ')

  puts "Set #{options[:name]} DNS to #{options[:dns].join(', ')} successfully!" if ret
end

def flush_dns
  system('dscacheutil -flushcache; sudo killall -HUP mDNSResponder;')
end

def usage
  puts <<-USAGE
  - dns         :show Wi-Fi DNS servers

  - dns defalut :remove Wi-Fi DNS servers(reset it to default)
  - dns opendns :set Wi-Fi DNS servers to OpenDNS(208.67.222.222, 208.67.220.220)
  - dns google  :set Wi-Fi DNS servers to Google(8.8.8.8)
  - dns v2ex    :set Wi-Fi DNS servers to V2EX(199.91.73.222, 178.79.131.110)

  - dns set     :set DNS servers

  - dns list    :show all network services

  - dns get     :show Wi-Fi DNS servers
  - dns get all :show all DNS servers

  - dns flush   :flush DNS cache
  USAGE
end

def dns_list
  YAML.load(File.read(File.expand_path('../dns.yml', __FILE__)))
end
