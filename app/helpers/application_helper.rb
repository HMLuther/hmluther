module ApplicationHelper

  def is_active?(link_path)
    if current_page?(link_path)
      "active"
    else
      ""
    end
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def flash_normal
   render "flashes"
  end

  def twitterized_type(type)
    case type
    when :errors
      "alert-error"
    when :alert
      "alert-warning"
    when :error
      "alert-error"
    when :notice
      "alert-success"
    else
      "alert-info"
    end
  end

  # DEVISE
  def resource_name
   :user
  end

  def resource
   @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

end
