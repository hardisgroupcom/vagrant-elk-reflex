#
# Cookbook Name:: elk-reflex
# Recipe:: logstash
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


template '/etc/logstash/conf.d/reflex.logstash.conf' do 
    source 'input.logstash.conf.erb'
    mode '0644'
    owner 'elk'
    group 'elk'
    variables({
        :redis_password => node['elk-reflex']['redis_password']
    })
end


service 'logstash' do
  action [:enable, :restart]
end