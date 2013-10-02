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
default['nopcommerce']['localzip'] = 'c:\nopCommerce.zip'

default['nopcommerce']['sampledatazip'] = 'https://dl.dropboxusercontent.com/u/58250/nopcommerce_data.zip'
default['nopcommerce']['localsampledatazip'] = 'c:\sampledatazip.zip'

# I like to isolate these away from the default, wwwroot
default['nopcommerce']['siteroot'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\sites\\nopCommerce"
default['nopcommerce']['approot'] = "#{ENV['SYSTEMDRIVE']}\\inetpub\\apps"
default['nopcommerce']['apppath'] = '/shop'
default['nopcommerce']['poolname'] = 'nopCommerce'
