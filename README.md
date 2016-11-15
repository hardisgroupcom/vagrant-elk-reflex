# chef-vagrant-elk-reflex

# vagrant-elk-hardis
This vagrant box installs a ready to use monitoring stack.
 This stack embeds :
 * Redis 3.2.1
 * Logstash 2.4.0
 * ElasticSearch 2.4.1
 * Kibana 4.6.1
 * InfluxDB 1.0.2
 * Grafana 3.1.1


## Prerequisites

[VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) (minimum version 1.6)


## Attributes

### Redis configuration 
In cookbooks/elk-hardis/attributes/default.rb
* `default['elk-hardis']['redis_password']` - Password used by Redis (and Logstash)

## Clone
```
git clone --recursive https://github.com/hardisgroupcom/vagrant-elk-reflex.git
```

## Up and SSH

To start the vagrant box run:

    vagrant up

To log in to the machine run:

    vagrant ssh

## Limitation
* This stack is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND.
* This stack is ready to use for **development purpose** and as a standalone stack. 
* This stack **is not securised** and must not be use in production without enabling security.

## Usage

Elasticsearch is available on the host machine at [http://localhost:9200/](http://localhost:9200/) 

Kibana is available on the host machine at [http://localhost:5601/](http://localhost:5601/)

Grafana  is available on the host machine at [http://localhost:3000/](http://localhost:3000/)
 
Redis is collecting data on the host machine at [tcp://localhost:6379](tcp://localhost:6379)

InfluxDB is collecting Collectd data on the host machine at [udp://localhost:25826](udp://localhost:25826)

InfluxDB is collecting Telegraf data on the host machine at [udp://localhost:25827](udp://localhost:25827)

You can collect any log4j or logback to redis by using :
* [log4j-redis-appender](https://github.com/hardisgroupcom/log4j-redis-appender)
* [logback-redis-appender](https://github.com/hardisgroupcom/logback-redis-appender)

You can collect any collectd data from [collectd](https://collectd.org) or from a jvm by using [jcollectd](https://github.com/hardisgroupcom/jcollectd)

## Dependencies

[chef-elk-hardis](https://github.com/hardisgroupcom/chef-elk-hardis) - Hardis elk cookbook

## License

Published under Apache Software License 2.0, see LICENSE
