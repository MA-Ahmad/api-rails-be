Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      # origins '*'
      origins 'http://localhost:3000'
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
    Rails.application.config.action_controller.forgery_protection_origin_check = false
  end
  