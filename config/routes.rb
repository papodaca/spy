require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? }  do
    ActiveAdmin.routes(self)
    mount Sidekiq::Web, at: "/sidekiq"
  end
  get "up", to: "rails/health#show", as: :rails_health_check

  post "/pub", to: "publication#create", constraints: {format: "json"}
  root to: "dashboard#index"
  match "*path", to: redirect("/"), via: :get
end
