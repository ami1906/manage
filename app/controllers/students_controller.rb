class StudentsController < ApplicationController
before_filter :set_cache_buster,:require_login,:student_config
   active_scaffold :"student" do |conf|
    conf.label="Student Details"
    conf.actions=[:create,:list,:search,:update,:delete,:subform]
    conf.delete.refresh_list = true
    conf.columns=[:rollno,:firstname,:lastname,:gender,:branch,:status]
    conf.search.columns = [:firstname,:lastname]
    conf.columns[:gender].clear_link
    conf.columns[:branch].clear_link
    conf.search.live=true
    conf.list.always_show_search=true
    conf.list.per_page = 25
    conf.action_links.add 'activate', :label => 'Activate', :type => :record, :confirm => 'Do you want to restore record?', :page => true
    conf.action_links.add 'destroy_record', :label => 'Destroy', :type => :record, :confirm => 'Do you want to remove record from Database?', :page => true
 end

   # Overriding Active Scaffolds method to select only active records when faculty logs in 
   # and select all records(both active and incative) when admin logs in.
   def beginning_of_chain
     if isAdmin
       active_scaffold_config.model.with_deleted
    else
      active_scaffold_config.model
    end
  end


  # Remove record from Database(Real Deletion)
  def destroy_record
   @record=Student.only_deleted.find(params[:id])
   flash[:info] = "Record with Firstname #{@record.firstname} has been Removed from Database"
   @record.destroy
   return_to_main
  end

  # Restore the deleted record
  def activate
    @record=Student.only_deleted.find(params[:id])
      flash[:info] = "Record with Firstname #{@record.firstname} has been Restored"
    @record.recover
  return_to_main
  end

  # Configure Active Scaffold for Students Controller based on Logged-in user role 
  def student_config
    # Exclude Status column for creat and update action
    active_scaffold_config.create.columns.exclude :status
    active_scaffold_config.update.columns.exclude :status
    # Show Status Column if the logged-in user is Admin else exclude it
    if isAdmin
      active_scaffold_config.list.columns.add :status
    else
      active_scaffold_config.list.columns.exclude :status
    end
  end

  # Overriding Active Sacffold method to allow delete action for Admin 
  def delete_authorized? record=nil
   isAdmin
  end

  # Overriding Active Scaffold method to allow create action for Admin
  def create_authorized? record=nil
   isAdmin
  end

end

