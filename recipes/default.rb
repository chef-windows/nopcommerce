#
# Cookbook Name:: nopcommerce
# Recipe:: default
# Author:: Julian C. Dunn (<jdunn@opscode.com>)
#
# Copyright (C) 2013 Opscode, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Windows::Helper)

windows_feature 'IIS-WebServerRole' do
  action :install
end

# Pre-requisite features for IIS-ASPNET45 that need to be installed first, in this order.
%w{IIS-ISAPIFilter IIS-ISAPIExtensions NetFx3ServerFeatures NetFx4Extended-ASPNET45 IIS-NetFxExtensibility45}.each do |f|
  windows_feature f do
    action :install
  end
end

windows_feature 'IIS-ASPNET45' do
  action :install
end

service "iis" do
  service_name "W3SVC"
  action :nothing
end

include_recipe "iis::remove_default_site"

windows_zipfile node['nopcommerce']['approot'] do
  source node['nopcommerce']['dist']
  action :unzip
  not_if {::File.exists?(::File.join(node['nopcommerce']['approot'], "nopCommerce"))}
end

%w{App_Data bin Content Content\\Images Content\\Images\\Thumbs Content\\Images\\Uploaded Content\\files\\ExportImport Plugins Plugins\\bin}.each do |d|
  directory win_friendly_path(::File.join(node['nopcommerce']['approot'], 'nopCommerce', d)) do
    rights :modify, 'IIS_IUSRS'
  end
end

%w{Global.asax web.config}.each do |f|
  file win_friendly_path(::File.join(node['nopcommerce']['approot'], 'nopCommerce', f)) do
    rights :modify, 'IIS_IUSRS'
  end
end

iis_pool node['nopcommerce']['poolname'] do
  runtime_version "4.0"
  action :add
end

directory node['nopcommerce']['siteroot'] do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end

iis_site 'nopCommerce' do
  protocol :http
  port 80
  path node['nopcommerce']['siteroot']
  application_pool node['nopcommerce']['poolname']
  action [:add,:start]
end

iis_app 'nopCommerce' do
  application_pool node['nopcommerce']['poolname']
  path node['nopcommerce']['apppath']
  physical_path "#{node['nopcommerce']['approot']}\\nopCommerce"
  action :add
end
