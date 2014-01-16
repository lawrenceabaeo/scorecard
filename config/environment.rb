# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Scorecard::Application.initialize!

YAML_CONFIG = YAML.load_file("#{Rails.root}/db/system_objects.yml")