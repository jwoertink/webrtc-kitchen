def data_bag_items(bag_name)
  data_bag(bag_name).map { |id| data_bag_item bag_name, id }
end

users = data_bag_items(:users)
ejabberd_user = data_bag_items(:ejabberd)
config_dir = "#{node['asterisk']['prefix']['conf']}/asterisk"

if platform_family?('rhel', 'fedora')
  lib_dir = node['kernel']['machine'] == 'x86_64' ? 'lib64' : 'lib'
else
  lib_dir = 'lib'
end

directory config_dir

template "#{config_dir}/asterisk.conf" do
  source 'asterisk.conf.erb'
  mode 0644
  variables lib_dir: lib_dir
  notifies :reload, resources('service[asterisk]')
end

template "#{config_dir}/xmpp.conf" do
  source 'xmpp.conf.erb'
  mode 0644
  variables user: ejabberd_user
  notifies :reload, resources('service[asterisk]')
end

%w{sip manager extensions}.each do |template_file|
  template "#{config_dir}/#{template_file}.conf" do
    source "#{template_file}.conf.erb"
    mode 0644
    variables users: users
    notifies :reload, resources('service[asterisk]')
  end
end
