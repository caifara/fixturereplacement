module FixtureReplacement
  class Railtie < Rails::Railtie
    config.after_initialize do
      FixtureReplacement.load_example_data
    end
  end
end