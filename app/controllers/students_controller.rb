class StudentsController < ApplicationController
before_filter :set_cache_buster,:require_login,:student_config
   active_scaffold :"student" do |conf|
    conf.label="Student Details"
    conf.actions=[:create,:list,:search,:update,:delete,:subform]
    conf.delete.refresh_list = true
    conf.columns=[:rollno,:firstname,:lastname,:gender,:branch,:status]
    conf.search.columns = [:firstname]
    conf.search.live=true
    conf.list.always_show_search=true
    conf.list.per_page = 25
    conf.action_links.add 'activate', :label => 'Restore', :type => :record, :confirm => 'Do you want to restore record?', :page => true
  end
def beginning_of_chain
  if isAdmin
     active_scaffold_config.model.with_deleted
  else
     active_scaffold_config.model
  end
end

 def activate
  @record=Student.only_deleted.find(params[:id])
   flash[:info] = "Record #{@record.firstname} has been Restored"
  @record.recover
return_to_main
end

def student_config
  active_scaffold_config.create.columns.exclude :status
  if isAdmin
      active_scaffold_config.list.columns.add :status
   else
     active_scaffold_config.list.columns.exclude :status
   end
end
 def delete_authorized? record=nil
  isAdmin
 end

 def create_authorized? record=nil
  isAdmin
 end

end

