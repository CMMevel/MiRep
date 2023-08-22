# cookbooks/my_wordpress/recipes/mysql.rb

package 'mysql-server' do
  action :install
end

# Define configuraciones adicionales aquí, como usuarios y bases de datos
