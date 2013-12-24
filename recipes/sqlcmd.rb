#
# Cookbook Name:: nopcommerce
# Recipe:: sqlcmd
# Authors:: Rhiannon Portwood (<rhiannon@getchef.com>)
## :: Alex Vinyar (<alexv@getchef.com>)
## :: Bakh Inamov (<bakh@getchef.com>)
## :: Isa Farnick (<isa@getchef.com>)
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
##DEFAULT ADMIN USER/PASS= admin@yourstore.com,admin


#Installs Drivers and SQL Command for 32 bit stuff
windows_package "ODBC Driver X32" do
  source "https://dl.dropboxusercontent.com/s/fri5ed57nhg39ex/msodbcsql_32.msi"
 action :install
  installer_type :msi
  options "IACCEPTMSODBCSQLLICENSETERMS=YES"
 only_if { node['kernel']['os_info']['os_architecture'] == '32-bit' }
end

windows_package "MSQL CMD Line Utilities X32" do
  source "https://dl.dropboxusercontent.com/s/2nkfzzbdqxppsfq/MsSqlCmdLnUtils_32.msi"
 action :install
  installer_type :msi
 options "IACCEPTMSSQLCMDLNUTILSLICENSETERMS=YES"
 only_if { node['kernel']['os_info']['os_architecture'] == '32-bit' }
end

#Installs Drivers and SQL Command for 64 bit stuff
windows_package "ODBC Driver X64" do
  source "https://dl.dropboxusercontent.com/s/omk8rg3h2sqldwx/msodbcsql_64.msi"
  action :install
  installer_type :msi
  options "IACCEPTMSODBCSQLLICENSETERMS=YES"
 only_if { node['kernel']['os_info']['os_architecture'] == '64-bit' }
end

windows_package "MSQL CMD Line Utilities X64" do
  source "https://dl.dropboxusercontent.com/s/qwcy245ehzws3hr/MsSqlCmdLnUtils_64.msi"
 only_if { node['kernel']['os_info']['os_architecture'] == '64-bit' }
 action :install
 installer_type :msi
 options "IACCEPTMSSQLCMDLNUTILSLICENSETERMS=YES"
end

#Merrily sets Path for sqlcmd
#Noticed this has to run twice sometimes to set the SQLCMD path...
windows_path "sqlcmd.exe" do
 path 'C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn'
  action :add
end

#Happily plops sql files from templates to the server 
#Two SQL files exist in templates, one is required data for the application to display content,
#the other has sample data prepopulated (default.)
template "#{node['nopcommerce']['required_sql']}" do
#not_if {::File.exists?(::File.join("#{node['nopcommerce']['required_sql']}"))}
source "nopcommerce_with_sample.sql"
end


#Joyfully Executing sql scripts against database
windows_batch "upload_initial_databases" do
  code <<-EOH
sqlcmd -S #{node['nopcommerce']['db']['host']} -U #{node['nopcommerce']['db']['user']} -P #{node['nopcommerce']['db']['password']} -i #{node['nopcommerce']['required_sql']}
 EOH
#not_if {::File.exists?(::File.join("#{node['nopcommerce']['dbstrings']}"))}
end


#Adding DB Connection Strings to Settings.txt
template "#{node['nopcommerce']['dbstrings']}" do
source "Settings.txt.erb"
#not_if {::File.exists?(::File.join("#{node['nopcommerce']['dbstrings']}"))}
end
