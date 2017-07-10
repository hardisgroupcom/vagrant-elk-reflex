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
  retries 3
  retry_delay 5
end

bash 'kibana creating searches' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/search/Error-List --data "@#{kibana_element_dir}/search_Error-List.json"
curl -XPOST #{url_elasticsearch}/.kibana/search/Traces --data "@#{kibana_element_dir}/search_Traces.json"
curl -XPOST #{url_elasticsearch}/.kibana/search/SQL-Dump-List --data "@#{kibana_element_dir}/search_SQL-Dump-List.json"
curl -XPOST ${url_elasticsearch}/.kibana/search/Trail-Audit --data "@${kibana_element_dir}/search_Trail-Audit.json"
    EOH
end


bash 'kibana creating visualizations' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Activity --data "@#{kibana_element_dir}/visualization_Activity.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Top-10-Errors --data "@#{kibana_element_dir}/visualization_Top-10-Errors.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Error-Number --data "@#{kibana_element_dir}/visualization_Error-Number.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Users --data "@#{kibana_element_dir}/visualization_Users.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Server-Role --data "@#{kibana_element_dir}/visualization_Server-Role.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/Programs --data "@#{kibana_element_dir}/visualization_Programs.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/SQL-Cursor --data "@#{kibana_element_dir}/visualization_SQL-Cursor.json"
curl -XPOST #{url_elasticsearch}/.kibana/visualization/SQL-Dump-Repartition --data "@#{kibana_element_dir}/visualization_SQL-Dump-Repartition.json"
    EOH
end


bash 'kibana creating dashboard' do
  code <<-EOH
curl -XPOST #{url_elasticsearch}/.kibana/dashboard/Main-Reflex --data "@#{kibana_element_dir}/dashboard_Main-Reflex.json"
curl -XPOST #{url_elasticsearch}/.kibana/dashboard/SQL-Dump-Reflex --data "@#{kibana_element_dir}/dashboard_SQL-Dump-Reflex.json"
curl -XPOST ${url_elasticsearch}/.kibana/dashboard/Session-Audit-Trail --data "@${kibana_element_dir}/dashboard_Session-Audit-Trail.json"
    EOH
end
