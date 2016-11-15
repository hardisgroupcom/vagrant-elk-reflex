#
# Cookbook Name:: elk-reflex
# Recipe:: grafana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'copy dashboards' do
    command 'cp /var/chef/cache/cookbooks/elk-reflex/files/default/grafana/*.json /var/lib/grafana/dashboards/'
end
execute 'add rights' do
    command 'chown grafana:grafana -R /var/lib/grafana/dashboards/'
end


service 'grafana-server' do
  action [:enable, :restart]
end