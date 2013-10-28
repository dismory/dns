# dns

A gem for configuring DNS on OS X

## Install

```shell
$ gem install dns
```

## Usage

```shell
$ dns -h
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
```

## License

dns is under the [MIT License](http://www.opensource.org/licenses/MIT).
