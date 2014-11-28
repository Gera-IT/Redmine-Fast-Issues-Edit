class OverlayController < IssuesController
  include ApplicationHelper

  respond_to :js, :html, :api
#
#   def render_form
#     @issue = Issue.find(params[:id])
#     @project = @issue.project
#     @allowed_statuses = @issue.new_statuses_allowed_to(User.current)
#     @edit_allowed = User.current.allowed_to?(:edit_issues, @project)
#     @priorities = IssuePriority.active
#     @time_entry = TimeEntry.new(:issue => @issue, :project => @issue.project)
#     @relation = IssueRelation.new
#     respond_to do |format|
#       format.js {render 'issues/render_form'}
#       format.html
#     end
#   end


  def create
    p 'hello'
    super
    if @issue.errors

    else
      respond_with(@issue)
    end

  rescue AbstractController::DoubleRenderError => msg
  #   p msg
    p "yo wsup"
    respond_with(:code => @issue)

  end
end