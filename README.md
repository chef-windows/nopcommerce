Description
===========

Installs and configures the nopCommerce ASP.NET shopping cart application with option to autogenerate prepopulated sql content to the SQL/Express server of your choice.

============
Requirements
============

Platforms
---------

* Windows Server 2012
* Windows Server 2012 R2
* 
Note: Windows Server 2008 and 2008 R2, as tested on ec2, do not appear to be working.


===========
Optional
============
Database
---------
For use of remote database connection strings, Microsoft SQL Full or SQL Express.



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



###nopcommerce::sqlcmd

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['dbstrings']</tt></td>
    <td>String</td>
    <td>Default path for database connection strings</td>
    <td><tt>Usually C:/inetpub/apps/nopCommerce/App_Data/Settings.txt </tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['required_sql']</tt></td>
    <td>String</td>
    <td>Temp storage of SQL Data</td>
    <td><tt>Path: Usually: C:/chef/cache/create_required_data.sql</tt></td>
  </tr>
    <tr>
    <td><tt>['nopcommerce']['sample_sql']</tt></td>
    <td>String</td>
    <td>Temp storage of SQL Data</td>
    <td><tt>Path: Usually: C:/chef/cache/create_sample_data.sql</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['db']['host']</tt></td>
    <td>String</td>
    <td>Environment Attribute, Role Attribute, Node Attribute that defines database host, IP, or endpoint (note that this connection string assumes your default port is 1433.</td>
    <td><tt>hostname</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['db']['database']</tt></td>
    <td>String</td>
    <td>Environment Attribute, Role Attribute, Node Attribute that defines the initial database name.</td>
    <td><tt>hostname</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['db']['user']</tt></td>
    <td>String</td>
    <td>Environment Attribute, Role Attribute, Node Attribute that defines database username with appropriate permissions to create database. </td>
    <td><tt>hostname</tt></td>
  </tr>
  <tr>
    <td><tt>['nopcommerce']['db']['password']</tt></td>
    <td>String</td>
    <td>Environment Attribute, Role Attribute, Node Attribute that defines database password.</td>
    <td><tt>hostname</tt></td>
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
### nopcommerce::sqlcmd

Installs demo data using remote database strings (SQL Server Full or Express). Special care taken to install sqlcmd.exe instead of full sql server.  If you do not want sample data, swap out sql file, or import your own using the path.  To utilize recipe, include `nopcommerce::sqlcmd` in your node's `run_list` or as an `include_recipe` directive in your `default.rb` recipe. The demo is reachable at http://your.server.name/shop  with initial admin credentials of user:admin@yourshop.com, password:admin (change those immediately):

Env/Role/Node attributes should be referenced in the following format:
```json

    "nopcommerce": {
      "db": {
        "host": "npcomm2.ceghs2ja2rph.us-east-1.rds.amazonaws.com",
        "database": "npcomm",
        "user": "npcomm",
        "password": "npcomm12"
      }
```



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
