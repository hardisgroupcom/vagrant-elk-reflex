# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.2"
  config.vm.box_version = "2.2.7"
  
  config.vm.box_check_update = false

  #Kibana
  config.vm.network :forwarded_port, guest: 5601, host: 5601
  #ElasticSearch
  config.vm.network :forwarded_port, guest: 9200, host: 9200
  #Grafana
  config.vm.network :forwarded_port, guest: 3000, host: 3000  

  #Redis
  config.vm.network :forwarded_port, guest: 6379, host: 6379
  #Infludb/CollectD
  config.vm.network :forwarded_port, guest: 25826, host: 25826, protocol: "udp"

  

  config.vm.synced_folder "cookbooks/elk-hardis/files/default/rpms", "/chef/elk-hardis/rpms"




  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "elk-reflex"
  end

end
