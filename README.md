# openstack-scripts

Currently works with Fuel 7.0 to find and update admin endpoints. 

Use case is: 

Administrative endpoint has been changed to a routable address and
has updated the Hostname associated with it. By default the admin_url
will be an IP address associated with the deployment. These scripts will 
update the value and verify the value and allow for you to revert the
values.

Check
sh check_admin_endpoints.sh

Update

sh update_admin_endpoint_to_ssl.sh

Rever

sh revert_update_admin_endpoints_to_ssl.sh
