Forem.user_class = "User"
Forem.email_from_address = "please-change-me@example.com"
# If you do not want to use gravatar for avatars then specify the method to use here:
Forem.default_gravatar = 'mm'
Forem.per_page = 5

Rails.application.config.to_prepare do
Forem::ApplicationController.layout "application"
Forem::Admin::BaseController.layout "application"
end


# Rails.application.config.to_prepare do
#   If you want to change the layout that Forem uses, uncomment and customize the next line:
#   Forem::ApplicationController.layout "forem"
#
#   If you want to add your own cancan Abilities to Forem, uncomment and customize the next line:
#   Forem::Ability.register_ability(Ability)
# end
#
# By default, these lines will use the layout located at app/views/layouts/forem.html.erb in your application.
