# -*- coding: utf-8 -*-

module ApplicationHelper
  # From Lupin V2
  #
  # Highlight the nav item if current page matching controllers_options
  #
  # Examples
  #
  #   nav_item 'Foo', '/foo', 'controller_foo', 'controller_bar'
  #   nav_item 'Foo', '/foo', %w(controller_foo controller_bar)
  #   nav_item 'Foo', '/foo', 'controller_foo', controller_bar: ['edit', 'new']
  #   nav_item 'Foo', '/foo', controller_foo: 'index', controller_bar: ['edit', 'new']
  #
  def nav_item(text, url, *controllers_options)
    controllers_options.flatten!

    options = controllers_options.extract_options!

    wrapper_options = if controller_name.in?(controllers_options) or
                         [ * options[controller_name.to_sym] ].include?(action_name)
                        {class: 'active'}
                      end

    nav_element(text, url, wrapper_options)
  end

  def nav_element(text, url, wrapper_options = {})
    content_tag :li, wrapper_options do
      link_to text, url
    end
  end

  def l(item, options = {})
    if item
      I18n.l(item, options)
    end
  end

  def undecorated(object)
    if object.is_a? Draper::Decorator
      object.source
    else
      object
    end
  end

  def js_controller_class
    if controller.class.name
      controller.class.name.gsub("::", "_")
    else
      controller.to_s
    end
  end

  def js_controller_action
    action_name
  end

  def object_link(object, path_proc, opts = {})
    opts[:for_empty] ||= "-"
    opts[:name_method] ||= "to_s"
    opts[:link_opts] ||= {}

    if object
      link_to object.public_send(opts[:name_method]),
              path_proc.call(object),
              opts[:link_opts]
    else
      opts[:for_empty]
    end
  end

  def links_for_collection(collection, path_proc, opts = {})
    collection.map do |object|
      object_link object, path_proc, opts
    end
  end

  def linked_names(collection, path_proc, opts = {})
    opts[:join_with] ||= ", "
    opts[:for_empty] ||= "-"
    links_for_collection(collection, path_proc, opts).join(opts[:join_with])
                                                     .html_safe.presence || opts[:for_empty]
  end

  def collection_list(collection, opts = {})
    opts[:for_empty] ||= "-"
    opts[:name_method] ||= "to_s"
    opts[:join_with] ||= ", "

    if collection && collection.any?
      collection.map do |member|
        member.public_send(opts[:name_method])
      end.join(opts[:join_with]).presence || opts[:for_empty]
    else
      opts[:for_empty]
    end
  end

  def site_url(site)
    if (url = site).present?
      if url.starts_with?("http")
        url
      else
        "http://#{url}"
      end
    end
  end

  def site_link(site)
    link_to site, site_url(site)
  end

  def confirmation_icon(value)
    if value
      content_tag(:span, '✓', class: 'badge badge-success')
    else
      content_tag(:span, '✘', class: 'badge badge-important')
    end
  end

  def teachers_audience?
    current_audience == "teachers"
  end

  def businesses_audience?
    current_audience == "businesses"
  end

  def for_teachers
    yield if teachers_audience? && block_given?
  end

  def for_businesses
    yield if businesses_audience? && block_given?
  end

  def inside_header_content
    contents = ["Make it in Great Britain"]
    unless %w(pages).include? controller_name
      unless action_name == "new" && controller_name == "schemes"
        contents << if businesses_audience?
                      "for businesses"
                    else
                      "for teachers"
                    end
      end
    end

    contents.join(" ")
  end

  def for_web
    yield unless mobile_device?
  end

  def for_mobile
    yield if mobile_device?
  end

  def google_analytics_init
    if SchemeFinderFrontend.google_analytics_tracker
      javascript_tag %Q(
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', #{SchemeFinderFrontend.google_analytics_tracker}, #{SchemeFinderFrontend.google_analytics_domain});
ga('send', 'pageview');
)
    end
  end
end
