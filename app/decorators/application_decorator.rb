class ApplicationDecorator < Draper::Decorator
  def as_json(options = {})
    as_decorated_json(options)
  end

  def as_decorated_json(options = {})
    model.as_json(options).merge(decorated_attributes(options))
  end

  def decorated_attributes(options = {})
    method_names = Array.wrap(options[:decorated_methods]).map { |n| n.to_s if respond_to?(n.to_s) }.compact
    Hash[method_names.map { |n| [n, send(n)] }].tap do |attrs|
      decorate_relations(attrs, options) if options[:decorated_include]
    end
  end

  def add_decorated_methods(options, method_names = [])
    options[:decorated_methods] = options[:decorated_methods] || []
    options[:decorated_methods].concat method_names
  end
end