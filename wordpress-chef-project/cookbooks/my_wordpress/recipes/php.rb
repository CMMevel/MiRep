# cookbooks/my_wordpress/recipes/php.rb

package 'php' do
  action :install
end

# Define configuraciones adicionales de PHP aquí, como módulos y ajustes
