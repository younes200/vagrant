require_recipe "git"

include_recipe "build-essential"


# sudo apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev
package "build-essential" do
  action :install
end

package "libxml2-dev" do
  action :install
end


git node[:cloud9][:dir] do
    repository node[:cloud9][:git]
    reference "master"
    action :checkout
    user "vagrant"
	group "vagrant"
end



#execute "cloud9-install" do
#  cwd node[:cloud9][:dir]
#  user 'vagrant'
#  command "su vagrant -l -c 'bash -i /usr/local/bin/npm install'"
#  action :run
#end


service "cloud9" do
  provider Chef::Provider::Service::Upstart
  #subscribes :restart, resources("git[checkout]")
  supports :restart => true, :start => true, :stop => true
end







template "cloud9.upstart.conf" do
  path "/etc/init/cloud9.conf"
  source "cloud9.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "cloud9")
end

service "cloud9" do
  action [:enable, :start]
end