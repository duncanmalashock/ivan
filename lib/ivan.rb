require 'yaml'

require_relative 'point'
require_relative 'has_transforms'
require_relative 'geometry'
require_relative 'glyph'
require_relative 'composition'
require_relative 'sender'
require_relative 'teensyv_sender'

module Ivan
  @model_path = File.join(File.dirname(File.expand_path(__FILE__)), 'models')
  @default_focal_length = -125.0
  Models = {}

  def self.models
    return Models
  end

  def self.set_focal_length(val)
    @default_focal_length = val
  end
  
  def self.set_model_path(path)
    @model_path = path
  end

  def self.default_focal_length
    return @default_focal_length
  end

  def self.load_models(*model_names)
    model_names.each do |model_name|
      model_file = File.read("#{ @model_path }/#{ model_name }.yml")
      if model_file then
        geom = YAML.load(model_file)
        if geom.valid? then
          Models[model_name] = geom
        end
      else
        return false
      end
    end
    return true
  end

  def self.copy_model(source, destination)
    if Models[source] then
      Models[destination] = Models[source]
    end
  end

  def self.save_model(model_name)
    yaml_out = YAML.dump(Models[model_name])
    if yaml_out then
      file_out = File.open("#{ @model_path }/#{model_name}.yml","w")
      file_out << yaml_out
      file_out.close
    end
  end
end