# chef-vagrant-elk-reflex

Installs and configures reflex monitoring stack, with:
 * Redis
 * Logstash
 * Elasticsearch
 * Kibana
 * Grafana


## Attributes

### Redis configuration 
In cookbooks/elk-hardis/attributes/default.rb
* `default['elk-hardis']['redis_password']` - Password used by Redis (and Logstash)

## Getting Started

```
git clone --recursive https://github.com/hardisgroupcom/chef-vagrant-elk-reflex.git
cd chef-vagrant-elk-reflex
vagrant up
```

## Dependencies

[chef-vagrant-elk-hardis](https://github.com/hardisgroupcom/chef-vagrant-elk-hardis) - Hardis elk cookbook
