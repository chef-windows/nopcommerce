Description
===========

Installs and configures the nopCommerce ASP.NET shopping cart application.

Requirements
============

Platforms
---------

* Windows Server 2012
* Windows Server 2012 R2

Windows Server 2008 and 2008 R2, as tested on ec2, do not appear to be working.

Cookbooks
---------

Lightweight Resources and Providers (LWRPs) from the following cookbooks are used:

* iis
* windows

Attributes
----------

#### nopcommerce::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['dist']</tt></td>
    <td>String</td>
    <td>Where to get the zip file from</td>
    <td><tt>https://dl.dropboxusercontent.com/u/47541301/nopCommerce/nopCommerce_3.10_NoSource.zip</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['demozip']</tt></td>
    <td>String</td>
    <td>Where to get the demo data zip file from</td>
    <td><tt>https://dl.dropboxusercontent.com/u/14471872/nopcommerce_data.zip</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['siteroot']</tt></td>
    <td>String</td>
    <td>Where the site root is for the nopCommerce website on this server</td>
    <td><tt>#{ENV['SYSTEMDRIVE']}\\inetpub\\sites\\nopCommerce</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['approot']</tt></td>
    <td>String</td>
    <td>Where the application will be installed to. The directory nopCommerce will be created here.</td>
    <td><tt>#{ENV['SYSTEMDRIVE']}\\inetpub\\apps</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['apppath']</tt></td>
    <td>String</td>
    <td>The relative path to the nopCommerce directory where the shop files will be created.</td>
    <td><tt>/shop</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['poolname']</tt></td>
    <td>String</td>
    <td>The app pool name to run nopCommerce under.</td>
    <td><tt>nopCommerce</tt></td>
  </tr>
</table>

Usage
=====

#### nopcommerce::default

Just include `nopcommerce` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nopcommerce]"
  ]
}
```

#### nopcommerce::demo

Installs demo data using built-in data storage (SQL Server Compact). Just include `nopcommerce::demo` in your node's `run_list`. The demo is reachable at http://your.server.name/shop :

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nopcommerce::demo]"
  ]
}
```
### Non-Local Database connection Strings.
Env/Role/Node attributes should be referenced in the following format:
{"defaults":{"nopcommerce":{"db":{"host":"test.opscode.com","database":"test","user":"test","password":"test}}
Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Author
==================

Author:: Julian C. Dunn (<jdunn@opscode.com>)

Copyright:: 2013, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
