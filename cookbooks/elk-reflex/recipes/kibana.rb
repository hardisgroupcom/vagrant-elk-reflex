#
# Cookbook Name:: elk-hardis
# Recipe:: kibana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


#################################
#KIBANA
#################################

bash 'kibana data' do
  code <<-EOH
curl -XPOST http://localhost:9200/.kibana/dashboard/DashBoardReflex -H 'kbn-version: 4.6.1' --data "@/vagrant/cookbooks/elk-reflex/files/default/reflex.kibana.json"  
    EOH
end



