# Instalar Ubuntu Desktop y realizar actualizaciones
package 'ubuntu-desktop' do
  action :install
end

# Realizar actualizaciones del sistema
execute 'apt-get-update' do
  command 'apt-get update'
  action :run
end

execute 'apt-get-upgrade' do
  command 'apt-get upgrade -y'
  action :run
end

# Instalar Apache, PHP, MySQL y WordPress
package 'apache2'
package 'php'
package 'mysql-server'
package 'wordpress'

# Configurar VirtualBox Guest Additions (este es un ejemplo básico)
execute 'install-vbox-additions' do
  command '/opt/VBoxGuestAdditions-7.0.8/bin/VBoxLinuxAdditions.run'
  action :run
  only_if { ::File.exist?('/opt/VBoxGuestAdditions-7.0.8/bin/VBoxLinuxAdditions.run') }
end

# Aceptar la licencia de Chef Infra Client
execute 'accept_chef_license' do
  command 'chef-client --chef-license accept'
  action :run
  not_if 'chef-client --chef-license status | grep -q "acceptance_version: 2"'
end

# Configurar redirección de / a /wordpress
template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Crear el archivo de configuración del sitio de WordPress
template '/etc/apache2/sites-available/wordpress.conf' do
  source 'wordpress.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Activar el sitio de WordPress
execute 'enable-wordpress-site' do
  command 'a2ensite wordpress.conf'
  action :run
end

# Reiniciar Apache para aplicar los cambios
service 'apache2' do
  action :restart
end