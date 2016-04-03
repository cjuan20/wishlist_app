Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' } do
	  resources :lists
  end
  resources :lists

  root 'landings#index'
  get 'secure' => 'landings#secure'
  get 'trend' => 'landings#trend'


end

#                   Prefix Verb   URI Pattern                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        registrations#cancel
#        user_registration POST   /users(.:format)               registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       registrations#new
#   edit_user_registration GET    /users/edit(.:format)          registrations#edit
#                          PATCH  /users(.:format)               registrations#update
#                          PUT    /users(.:format)               registrations#update
#                          DELETE /users(.:format)               registrations#destroy
#                    lists GET    /lists(.:format)               lists#index
#                          POST   /lists(.:format)               lists#create
#                 new_list GET    /lists/new(.:format)           lists#new
#                edit_list GET    /lists/:id/edit(.:format)      lists#edit
#                     list GET    /lists/:id(.:format)           lists#show
#                          PATCH  /lists/:id(.:format)           lists#update
#                          PUT    /lists/:id(.:format)           lists#update
#                          DELETE /lists/:id(.:format)           lists#destroy
#                     root GET    /                              landings#index
#                   secure GET    /secure(.:format)              landings#secure
#                    trend GET    /trend(.:format)               landings#trend



