# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html



  get :render_form, to: 'issues#render_form'



  get "projects/:project_id/render_new_form", to: 'issues#render_new_form'
  # resources :projects do
  #   member do
  #     get :render_new_form
  #   end
  # end

