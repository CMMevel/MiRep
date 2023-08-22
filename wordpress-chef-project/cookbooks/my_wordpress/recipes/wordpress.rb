# cookbooks/my_wordpress/recipes/wordpress.rb

package 'wordpress' do
  action :install
end

# Define configuraciones adicionales de WordPress aquí, como la configuración de la base de datos y otros ajustes
