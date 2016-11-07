#
# Cookbook Name:: elk-reflex
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'elk-hardis::default'

include_recipe 'elk-reflex::grokpatterns'
include_recipe 'elk-reflex::logstash'
include_recipe 'elk-reflex::grafana'