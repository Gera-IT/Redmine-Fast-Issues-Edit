require 'assets_hook'
require 'redmine'
# require 'redmine_overlay_issues_manager/issues_controller_patch'

Redmine::Plugin.register :redmine_overlay_issues_manager do
  name 'Redmine Overlay Issues Manager plugin'
  author 'Alex Sinelnikov'
  description 'Overlay issue creating\edition'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'



  project_module :overlay do
    permission :allow_edit_overlay, :issues => :render_form
    permission :allow_new_overlay, :issues => :render_new_form
  end

  module IssuesControllerPatch
    def self.included(base)

      base.class_eval do
        before_filter :find_project_js, :build_new_issue_from_params, :only => :render_new_form
        before_filter :authorize, :only => :render_new_form
        skip_before_filter :authorize, :only => :render_form
        unloadable
      end
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def find_project_js
        @project ||= Project.find(params[:project_id])
      end

      def render_new_form
        @edit_allowed = User.current.allowed_to?(:edit_issues, @project)
        @priorities = IssuePriority.active
        @relation = IssueRelation.new
        respond_to do |format|
          format.js
          format.html
        end
      end

      def render_form
        @issue = Issue.find(params[:id])
        @project = @issue.project
        @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
        @edit_allowed = User.current.allowed_to?(:edit_issues, @project)
        @priorities = IssuePriority.active
        @time_entry = TimeEntry.new(:issue => @issue, :project => @issue.project)
        @relation = IssueRelation.new
        respond_to do |format|
          format.js {render 'issues/render_show'}
          format.html
        end
      end
    end
  end

  ActionDispatch::Callbacks.to_prepare do
    IssuesController.send(:include, IssuesControllerPatch)
  end

end

class AssetsHook < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = { })
    javascript_include_tag('overlay.js', :plugin => 'redmine_overlay_issues_manager') +
        javascript_include_tag('jquery.simplemodal.js', :plugin => 'redmine_overlay_issues_manager') +
        stylesheet_link_tag('application.css', :plugin => 'redmine_overlay_issues_manager')
  end
end