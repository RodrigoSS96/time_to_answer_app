# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

#Pré-Compile App Assets
Rails.application.config.assets.precompile += %w( 
                                                  admins_backoffice.coffee
                                                  admins_backoffice.scss
                                                  users_backoffice.coffee
                                                  users_backoffice.scss
                                                  admin_devise.coffee
                                                  admin_devise.scss
                                                  user_devise.coffee
                                                  user_devise.scss
                                                  site.coffee
                                                  site.scss
                                                )

#Pré-Compile Lib Assets
Rails.application.config.assets.precompile += %w( 
                                                  jquery.easing.min.js
                                                  sb-admin-2.min.js
                                                  sb-admin-2.min.css
                                                  bootstrap.bundle.min.js
                                                  bootstrap.bundle.min.js.map
                                                  custom.min.js
                                                  custom.min.css
                                                  navbar-top.css
                                                  img.jpg
                                                  undraw_profile.svg
                                                  undraw_profile_1.svg
                                                  undraw_profile_2.svg
                                                  undraw_profile_3.svg
                                                  undraw_profile_4.svg
                                                )

#Pré-Compile Vendor Assets
Rails.application.config.assets.precompile += %w(
                                                  jquery-2.2.4/dist/jquery.min.js
                                                )