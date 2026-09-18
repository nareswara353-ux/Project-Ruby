class ApplicationSerializer
  attr_reader :object, :options

  def initialize(object, options = {})
    @object = object
    @options = options
  end

  def self.serialize(object, options = {})
    return object.map { |o| new(o, options).as_json } if object.is_a?(Enumerable)

    new(object, options).as_json
  end

  def as_json
    raise NotImplementedError, "#{self.class} must implement #as_json"
  end
end
