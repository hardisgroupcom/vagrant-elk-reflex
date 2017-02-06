# vagrant-elk-reflex


This vagrant box installs a ready to use monitoring stack on your machine.

This ELK stack is preconfigured for Reflex Web.

 This stack embeds :
 * Redis 3.2.1
 * Logstash 2.4.0
 * ElasticSearch 2.4.1
 * Kibana 4.6.1
 * InfluxDB 1.1.1
 * Grafana 4.0.2


## Limitation
* This stack is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND.
* This stack is ready to use for **development purpose** and as a standalone stack.
* This stack **is not securised** and must not be use in production without enabling security.


## Prerequisites

* [VirtualBox](https://www.virtualbox.org/) 
* [Vagrant](http://www.vagrantup.com/) (minimum version 1.6)
* [Git](https://git-scm.com/)


## Get the stack

Open a command-line prompt into your working directory and execute :
```
git clone --recursive https://github.com/hardisgroupcom/vagrant-elk-reflex.git
```

A directory named `vagrant-elk-reflex` containing the monitoring stack is created.


## Settings

### Memory allocation

By default, memory allocated to the virtual machine is 2 GB.

To update this value, edit file `Vagrantfile` line `vb.memory`.


### Redis configuration

By default, the password defined to Redis is `changeMe`.

To update this value, edit file `cookbooks/elk-hardis/attributes/default.rb` to set :

`default['elk-hardis']['redis_password']` - Password used by Redis (and Logstash)


### Retention configuration

By default, the retention duration is 3 days.

To update this value, edit file `cookbooks/elk-hardis/attributes/default.rb` to set :

`default['elk-hardis']['retention_days_number']` - retention duration in days used by ElasticSearch and InfluxDB.


## Start

To start the vagrant box run :
    ```
    vagrant up
    ```

The first start takes time (up to 30 minutes according to network bandwidth) because it retrieves several libraries from network repositories.

To get help about vagrant usage run :
	```
	vagrant help
	```

## Usage

The monitoring stack is now ready to be use.

* Elasticsearch is available on the host machine at [http://localhost:9200/](http://localhost:9200/).

* Kibana is available on the host machine at [http://localhost:5601/](http://localhost:5601/). See [Kibana_usage_guide.pdf](Documentation/Kibana_usage_guide.pdf).

* Grafana  is available on the host machine at [http://localhost:3000/](http://localhost:3000/). See [Grafana_usage_guide.pdf](Documentation/Grafana_usage_guide.pdf).
 
* Redis is collecting data on the host machine at [tcp://localhost:6379](tcp://localhost:6379).

* InfluxDB is collecting Collectd data on the host machine at [udp://localhost:25826](udp://localhost:25826).

* InfluxDB is collecting Telegraf data on the host machine at [udp://localhost:25827](udp://localhost:25827).


You can collect any log4j to redis by using [log4j-redis-appender](https://github.com/hardisgroupcom/log4j-redis-appender).

You can collect any collectd data from [collectd](https://collectd.org) or from a jvm by using [jcollectd](https://github.com/hardisgroupcom/jcollectd).


## Reflex Web connection

Now you can configure your Reflex Web server to use this monitoring stack.

### Log4j

Log4j trace configuration is explained into the infrastructure guide of the product.


### Jcollectd

A jcollectd configuration ready to be used for Reflex Web is provided in `external/jcollectd` directory.

This configuration allows Reflex Web JVMs to send metrics to the monitoring stack.

In order to use this configuration :

* copy this directory on your Reflex Web server

* add the following parameters to your web-server JVM : 

	```
	-javaagent:/path/to/jcollectd/jcollectd-hardisgroupcom-1.0.1.jar;-Djcd.properties=/path/to/jcollectd/wagon-jcollectd.properties;
	```

* add the following parameters to your batch-server JVM (jmiddleware) : 

	```
	-javaagent:/path/to/jcollectd/jcollectd-hardisgroupcom-1.0.1.jar -Djcd.properties=/path/to/jcollectd/jmiddleware-jcollectd.properties
	```


## Auto start

### Windows

To automatically start the monitoring stack on a Windows machine :

* copy the file `external\startReflexElkStack.bat` into directory `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\`.

* edit the script file to define the location of the vagrant-elk-reflex project.

The monitoring stack is automatically started when you start your machine.


### Linux

To automatically start the monitoring stack on a Linux machine :

* copy the file `external/startReflexElkStack.sh` into directory `/etc/profile.d`

* make the script executable : `chmod +x startReflexElkStack.sh`

* edit the script file to define the location of the vagrant-elk-reflex project.

The monitoring stack is automatically started when you start your machine.


## Update

This project is versionned using Git.

In order to update your local version, run `git pull` on the master branch.

To update the vagrant box, run :
* `vagrant provision`       if the monitoring stack is already started
* `vagrant up --provision`  if the monitoring stack is stopped


## Dependencies

[chef-elk-hardis](https://github.com/hardisgroupcom/chef-elk-hardis) - Hardis elk cookbook

## License

Published under Apache Software License 2.0, see LICENSE
