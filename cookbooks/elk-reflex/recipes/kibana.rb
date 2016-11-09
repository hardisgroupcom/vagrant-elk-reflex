#
# Cookbook Name:: elk-hardis
# Recipe:: kibana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


#################################
#KIBANA
#################################
url_elasticsearch = 'http://localhost:9200'
kibana_element_dir = '/vagrant/cookbooks/elk-reflex/files/default/kibana'
#
# Commands to export Kibana element :
#       - curl http://localhost:9200/.kibana/dashboard/DASHBOARD_NAME/_source?pretty=1 > DASHBOARD_FILE.json 
#		- curl http://localhost:9200/.kibana/visualization/VISUALIZATION_NAME/_source?pretty=1 > VISUALIZATION_FILE.json 
#		- curl http://localhost:9200/.kibana/search/SEARCH_NAME/_source?pretty=1 > SEARCH_FILE.json
#

bash 'kibana creating index' do
  code <<-EOH
curl -XDELETE #{url_elasticsearch}/logstash-*
curl -XPOST #{url_elasticsearch}/_template/reflex --data "@#{kibana_element_dir}/template_reflex.json"
curl -XPOST #{url_elasticsearch}/.kibana/index-pattern/logstash-* -d '{"title" : "logstash-*",  "timeFieldName": "@timestamp"}'
curl -XPUT #{url_elasticsearch}/.kibana/config/4.6.1 -d '{"defaultIndex" : "logstash-*"}'
    EOH
end

bash 'kibana creating searches' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/search/Error-List --data "@#{kibana_element_dir}/search_Error-List.json"
    EOH
end


bash 'kibana creating visualizations' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Trace-Activity --data "@#{kibana_element_dir}/visualization_Trace-Activity.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Top-10-Error-Messages --data "@#{kibana_element_dir}/visualization_Top-10-Error-Messages.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Error-Number --data "@#{kibana_element_dir}/visualization_Error-Number.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/User-List --data "@#{kibana_element_dir}/visualization_User-List.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Server-Role --data "@#{kibana_element_dir}/visualization_Server-Role.json"
    EOH
end


bash 'kibana creating dashboard' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/dashboard/DashboardReflex --data "@#{kibana_element_dir}/dashboard_DashboardReflex.json"
    EOH
end
