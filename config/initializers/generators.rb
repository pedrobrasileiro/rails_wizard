Rails.application.config.generators do |g|
  g.orm :mongo_mapper
  g.test_framework :rspec
end