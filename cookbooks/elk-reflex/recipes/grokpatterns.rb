#
# Cookbook Name:: elk-reflex
# Recipe:: grokpatterns
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'copy grok patterns' do
    command 'cp -R /var/chef/cache/cookbooks/elk-reflex/files/default/grok-patterns /etc/logstash/'
end

execute 'change owner' do
    command 'chown elk:elk -R /etc/logstash/grok-patterns'
end

execute 'add rights' do
    command 'chmod 644 -R /etc/logstash/grok-patterns'
end

service 'logstash' do
  action [:enable, :restart]
end
