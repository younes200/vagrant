# -*- mode: ruby -*-
# vi: set ft=ruby :

require "rubygems"
require "json"   
require 'rbconfig'


IS_WINDOWS = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/) ? true : false

Vagrant::Config.run do |config|
	config.vm.define :nodejsvm do |nodejs_config|
		nodejs_config.vm.box = "precise64"
    
    nodejs_config.vm.network :hostonly, "192.168.33.120"
    nodejs_config.vm.share_folder("projects", "/home/vagrant/www", "../", :nfs => true, :create => true) if !IS_WINDOWS
    
    
		nodejs_config.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
      chef.log_level = :debug
chef.add_recipe "build-essential"
                        chef.add_recipe "git"
                        chef.add_recipe "apt"
                        #chef.add_recipe "nodejs"
                        chef.add_recipe "vim"
      chef.add_recipe "imagemagick"
      chef.add_recipe "cloud9"
      chef.add_recipe "redis"
      chef.json.merge!(JSON.parse(File.read('dna.json')))
		end
	end
	
  
  config.vm.forward_port 3000, 3000
  config.vm.forward_port 3001, 3001
  config.vm.forward_port 8088, 8088
  config.vm.forward_port 8888, 8888
  config.vm.forward_port 27017, 27017 
    
 end
