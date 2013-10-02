#
# Cookbook Name:: nopcommerce
# Recipe:: default
# Author:: Bakh Inamov (<bakh@opscode.com>)
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

include_recipe "nopcommerce"

#Get the sample data zipfile
remote_file node['nopcommerce']['localsampledatazip'] do
  source node['nopcommerce']['sampledatazip']
end

#uncompress the sample data zipfile
batch "unzip sample data to nopcommerce" do
  code "#{node['7-zip']['home']}\\7z.exe x #{node['nopcommerce']['localsampledatazip']} -o#{node['nopcommerce']['approot']}\\nopCommerce -y"
  creates "#{node['nopcommerce']['approot']}\\nopCommerce\\App_Data\\Nop.Db.sdf"
end