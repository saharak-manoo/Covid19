class UserDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def created_at_formatted
    datetime_formatted(created_at)
  end  

  def updated_at_formatted
    datetime_formatted(updated_at)
  end

  def deleted_at_formatted
    datetime_formatted(deleted_at)
  end

  def photo
    object.photo
  end

  def photo_url
    photo&.url
  end

  def admin
    object&.has_role?(:admin).present? ? object&.has_role?(:admin) : false
  end

  def roles
    object.roles
  end

  def datetime_formatted(date)
    date.strftime('%d/%m/%Y เมื่อเวลา %H:%M') rescue ''
  end  
end