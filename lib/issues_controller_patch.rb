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
            format.js {render 'issues/render_show'}
            format.html
          end
        end

      end
    end
  end
end