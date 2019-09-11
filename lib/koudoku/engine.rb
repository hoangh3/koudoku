require 'stripe'
require 'bluecloth'
module Koudoku
  class Engine < ::Rails::Engine
    isolate_namespace Koudoku
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    config.to_prepare do
      Dir.glob(Rails.root + "app/overrides/**/*_override*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer 'koudoku.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        include Koudoku::ApplicationHelper
      end
    end

  end
end
