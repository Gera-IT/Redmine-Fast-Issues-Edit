class OverlayController < IssuesController
  include ApplicationHelper
  include IssuesHelper

  respond_to :js, :html, :api

  def update
    return unless update_issue_from_params
    @issue.save_attachments(params[:attachments] || (params[:issue] && params[:issue][:uploads]))
    saved = false
    begin
      saved = save_issue_with_child_records
    rescue ActiveRecord::StaleObjectError
      @conflict = true
      if params[:last_journal_id]
        @conflict_journals = @issue.journals_after(params[:last_journal_id]).all
        @conflict_journals.reject!(&:private_notes?) unless User.current.allowed_to?(:view_private_notes, @issue.project)
      end
    end

    if saved
      retrieve_query
      sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
      sort_update(@query.sortable_columns)
      @issues = Issue.where(id: @issue.id)
      @errors = 0
      render_attachment_warning_if_needed(@issue)
      flash[:notice] = l(:notice_successful_update) unless @issue.current_journal.new_record?

      respond_to do |format|
        format.html { redirect_back_or_default issue_path(@issue) }
        format.js {render :template => '/issues/update_issue'}
        format.api  { render_api_ok }
      end
    else
      @errors = @issue.errors.count
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.js {render :template => '/issues/render_form'}
        format.api  { render_validation_errors(@issue) }
      end
    end
  end

  def create

      call_hook(:controller_issues_new_before_save, { :params => params, :issue => @issue })
      @issue.save_attachments(params[:attachments] || (params[:issue] && params[:issue][:uploads]))
      if @issue.save
        retrieve_query
        sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
        sort_update(@query.sortable_columns)
        @issues = Issue.where(id: @issue.id)
        @errors = 0
        call_hook(:controller_issues_new_after_save, { :params => params, :issue => @issue})
        respond_to do |format|
          format.html {
            render_attachment_warning_if_needed(@issue)
            flash[:notice] = l(:notice_issue_successful_create, :id => view_context.link_to("##{@issue.id}", issue_path(@issue), :title => @issue.subject))
            if params[:continue]
              attrs = {:tracker_id => @issue.tracker, :parent_issue_id => @issue.parent_issue_id}.reject {|k,v| v.nil?}
              redirect_to new_project_issue_path(@issue.project, :issue => attrs)
            else
              redirect_to issue_path(@issue)
            end
          }

          format.js {render '/issues/add_new_issue'}
          format.api  { render :action => 'show', :status => :created, :location => issue_url(@issue) }
        end
        return
      else
        @errors = @issue.errors.count
        respond_to do |format|
          format.html { render :action => 'new'}
          format.api  { render_validation_errors(@issue) }
          format.js {render :template => '/issues/render_new_form', :locals => {:saved => :false}}
        end
    end
  end
end