module IssuesPatch
  module IssuesControllerPatch
    def self.included(base)
      base.class_eval do
        # Insert overrides here, for example:

        def render_overlay
          @issue = Issue.find(params[:id])
          @project = @issue.project
          @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
          @edit_allowed = User.current.allowed_to?(:edit_issues, @project)
          @priorities = IssuePriority.active
          @time_entry = TimeEntry.new(:issue => @issue, :project => @issue.project)
          @relation = IssueRelation.new
          respond_to do |format|
            format.js {render 'issues/render_form'}
            format.html
          end
        end

        # def show_with_plugin
        #   show_without_plugin
        # end
        # alias_method_chain :show, :plugin # This tells Redmine to allow me to extend show by letting me call it via "show_without_plugin" above.
        # # I can outright override it by just calling it "def show", at which case the original controller's method will be overridden instead of extended.
      end
    end
  end
end