class AssetsHook < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    javascript_include_tag('overlay.js', :plugin => 'redmine_overlay_issues_manager')
  end
end