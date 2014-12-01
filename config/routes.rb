# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html



  get :render_form, to: 'issues#render_form'

  post :create_issue_from_overlay, to: 'overlay#create'
  put :update_issue_from_overlay, to: 'overlay#update'



  get :render_new_form, to: 'issues#render_new_form'
  # resources :projects do
  #   member do
  #     get :render_new_form
  #   end
  # end

