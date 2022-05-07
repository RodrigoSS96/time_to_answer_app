Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'search/subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end

  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end

  get 'backoffice', to: 'users_backoffice/welcome#index'

  namespace :admins_backoffice do
    get 'welcome/index' #WelcomeController
    resources :admins #AdminsController
    resources :subjects #SubjectsController
    resources :questions #QuestionsController
    #O resoucers gera automaticamente todas as rotas do Controller (Create, Edit, Update, Destroy...).
    #O only é utilizado para criar apenas as rotas indicadas na instrução. Exemplo (Apenas a Rota da Action Index)
    #O except é utilizado para definir as rotas que não devem ser criadas. Ex: (Crie todas as rotas, menos a rota Destroy)
    #Sintax: resources :nome_controller
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :users

  get 'inicio', to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "site/welcome#index"
end
