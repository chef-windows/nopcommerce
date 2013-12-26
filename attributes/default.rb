#
# Cookbook Name:: nopcommerce
# Attributes:: default
#
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['nopcommerce']['dist'] = 'https://dl.dropboxusercontent.com/u/47541301/nopCommerce/nopCommerce_3.10_NoSource.zip'
default['nopcommerce']['demozip'] = 'https://dl.dropboxusercontent.com/u/14471872/nopcommerce_data.zip'

# I like to isolate these away from the default, wwwroot
default['nopcommerce']['siteroot'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\sites\\nopCommerce"
default['nopcommerce']['approot'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\apps"
default['nopcommerce']['apppath'] = '/shop'
default['nopcommerce']['poolname'] = 'nopCommerce'
default['nopcommerce']['dbstrings'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\apps\\nopCommerce\\App_Data\\Settings.txt"


#Adding some more attributes to help with sqlcmd.rb
default['nopcommerce']['required_sql'] = "#{ENV['SYSTEMDRIVE']}\\chef\\cache\\create_required_data.sql"
default['nopcommerce']['sample_sql'] = "#{ENV['SYSTEMDRIVE']}\\chef\\cache\\create_sample_data.sql"
default['nopcommerce']['dbstrings'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\apps\\nopCommerce\\App_Data\\Settings.txt"
default['nopcommerce']['arch'] = node['kernel']['os_info']['os_architecture']

# Set your database connection strings here
default['nopcommerce']['db']['host'] = 'nopcommerce.ceghs2ja2rph.us-east-1.rds.amazonaws.com'
default['nopcommerce']['db']['database'] = 'nopcommerce'
default['nopcommerce']['db']['user'] = 'opscode' 
default['nopcommerce']['db']['password'] = 'opscode123'
