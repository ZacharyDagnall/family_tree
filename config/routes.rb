Rails.application.routes.draw do
  
  root to: "welcome#index", as: "root"

  
  resources :people 
  resources :filials
  resources :marriages  

  # get "/people/:surname", to: "", as: "family_path"
  
  
end
