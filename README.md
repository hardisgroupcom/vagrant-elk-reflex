# Reflex Monitoring Tool

The Reflex Monitoring Tool use Vagrant to install a ready-to-use virtual machine on your server.

This tool embeds the following technologies :
 * Redis 3.2.1
 * Logstash 2.4.0
 * ElasticSearch 2.4.1
 * Kibana 4.6.1
 * InfluxDB 1.1.1
 * Grafana 4.0.2


## Version
9.6

## Limitation
This tool is distributed on an **"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND**.
This tool is ready to use **as a standalone stack** :

	* Not designed for a large scale usage
	* Not securised
	* No high availability
	* No authentication


## Service

A Reflex Monitoring Tool with advanced features (large scale sizing, high availability, security, authentication, ...) requires supplementary services. Please contact your project manager at Hardis to get a quotation.


## Prerequisites

### Hardware

It is strongly recommended to use a dedicated server to install the monitoring tool. And to not install it on a server where a Reflex instance is running.

Hardware virtualization feature has to be enabled on the server processor.

The disk space usage depends on the number of Reflex server connected, the trace quantity sent and the retention duration configured. It is recommended to start with at least 50 GB.


### Software

The following applications have to be installed on your host server before installing the Reflex monitoring tool :

* [VirtualBox](https://www.virtualbox.org/) 
* [Vagrant](http://www.vagrantup.com/) (minimum version 1.6)
* [Git](https://git-scm.com/)



## Get the stack

Open a command-line prompt into your working directory and execute :
```
git clone --recursive https://github.com/hardisgroupcom/vagrant-elk-reflex.git
```

A directory named `vagrant-elk-reflex` containing the monitoring tool project is created.


## Start

Into a command-line prompt, move into the monitoring tool project directory :
```
cd vagrant-elk-reflex
```

To start the vagrant box run :
```
vagrant up
```

The first start takes time (up to 30 minutes according to network bandwidth) because it retrieves several libraries from network repositories.

## Usage

The reflex Monitoring Tool is now ready to use with 2 front-end tools : 

* The Reflex server monitoring tool (Grafana) is available on the host machine at [http://localhost:3000/](http://localhost:3000/). 
See [Grafana_usage_guide.pdf](Documentation/Grafana_usage_guide.pdf).

* The Reflex trace analysis tool (Kibana) is available on the host machine at [http://localhost:5601/](http://localhost:5601/app/kibana#/dashboard/Main-Reflex). 
See [Kibana_usage_guide.pdf](Documentation/Kibana_usage_guide.pdf).


## Reflex Web connection

Now you can configure your Reflex Web server to use this monitoring stack.

### Log4j

Log4j trace configuration is explained into the infrastructure guide of the product.


### Jcollectd

Jcollectd Reflex configuration files are provided in Reflex product :
	* conf/wagon-jcollectd.properties
	* conf/jmiddleware-jcollectd.properties

This configuration allows Reflex Web JVMs to send metrics to the monitoring tool.

In order to use this configuration :

* download the jcollectd library from `url to be defined`

* deploy this library on all Reflex server you would like to monitor. *Do not place this library inside the Reflex product directory path*.

* update Reflex JVM parameters to send collectd metrics : 
	* On Linux 
		* For the web server JVMs, update `CATALINA_CUSTOM_PARAM` variable of `conf/unix_rfx_web_config` file to add :

			```
			-javaagent:/path/to/jcollectd/jcollectd-hardisgroupcom-1.0.1.jar -Djcd.properties=$REFLEX_HOME/conf/wagon-jcollectd.properties
			```

		* For the batch server JVMs, update `RFX_CUSTOM_PARAM` variable of `conf/unix_rfx_jdaemon_config` file to add :

			```
			-javaagent:/path/to/jcollectd/jcollectd-hardisgroupcom-1.0.1.jar -Djcd.properties=$REFLEX_HOME/conf/jmiddleware-jcollectd.properties
			```

		* Restart Reflex services : `reflex_services.sh restart`

	* On Windows
		* For the web server JVMs, update `CATALINA_CUSTOM_PARAM` variable of `conf/reflex_cloud_service_config.bat` file to add :

			```
			-javaagent:\path\to\jcollectd\jcollectd-hardisgroupcom-1.0.1.jar;-Djcd.properties=%REFLEX_HOME%\conf\wagon-jcollectd.properties;
			```

		* For the batch server JVMs, update `RFX_CUSTOM_PARAM` variable of `conf/unix_rfx_jdaemon_config.bat` file to add :

			```
			-javaagent:\path\to\jcollectd\jcollectd-hardisgroupcom-1.0.1.jar -Djcd.properties=%REFLEX_HOME%\conf\jmiddleware-jcollectd.properties
			```

		* Uninstall the Reflex services :
			* Execute `%REFLEX_HOME%\product\bin\reflex_cloud_service_uninstall.bat`
			* Execute `%REFLEX_HOME%\product\bin\win_rfx_jdaemon_uninstall.bat`
		* (Re)Install the Reflex services :
			* Execute `%REFLEX_HOME%\product\bin\reflex_cloud_service_install.bat`
			* Execute `%REFLEX_HOME%\product\bin\win_rfx_jdaemon_install.bat`



## Settings

The following monitoring tool settings can be customized.

### Memory allocation

By default, memory allocated to the virtual machine is 2 GB.

To update this value, edit file `Vagrantfile` line `vb.memory`.


### Redis configuration

By default, the password defined to Redis is `changeMe`.

To update this value, edit file `cookbooks/elk-hardis/attributes/default.rb` to set :

`default['elk-hardis']['redis_password']` - Password used by Redis (and Logstash)


### Data retention configuration

By default, the retention duration of monitoring data is 3 days.

To update this value, edit file `cookbooks/elk-hardis/attributes/default.rb` to set :

`default['elk-hardis']['retention_days_number']` - retention duration in days used by ElasticSearch and InfluxDB.


### Internal configuration

The back-end tools are configured as follow :

* Elasticsearch is available on the host machine at [http://localhost:9200/](http://localhost:9200/).

* Redis is collecting data on the host machine at [tcp://localhost:6379](tcp://localhost:6379).

* InfluxDB is collecting Collectd data on the host machine at [udp://localhost:25826](udp://localhost:25826).

* InfluxDB is collecting Telegraf data on the host machine at [udp://localhost:25827](udp://localhost:25827).

* Logstash is reading data from Redis with key 'wms' and pushing to ElasticSearch with index 'logstash-%{+YYYY.MM.dd}'.


You can collect any log4j to redis by using [log4j-redis-appender](https://github.com/hardisgroupcom/log4j-redis-appender).

You can collect any collectd data from [collectd](https://collectd.org) or from a jvm by using [jcollectd](https://github.com/hardisgroupcom/jcollectd).


## Auto start

### Windows


### Linux



## Update

### Deploy new settings

Each time you modify the settings, you have to update the running instance of the monitoring tool.

From the monitoring tool project directory, run :
* `vagrant provision`       if the monitoring stack is already started
* `vagrant up --provision`  if the monitoring stack is stopped

You can get more details about Vagrant commands by running :

	```
	vagrant help
	```


### Get last changes

This project is versionned using Git.

In order to update your local version from the GitHub repository, run `git pull` on the master branch.


## Dependencies

[chef-elk-hardis](https://github.com/hardisgroupcom/chef-elk-hardis) - Hardis elk cookbook

## License

Published under Apache Software License 2.0, see LICENSE
