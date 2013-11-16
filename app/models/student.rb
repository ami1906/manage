class Student < ActiveRecord::Base
  attr_accessible :branch_id, :firstname, :gender_id, :lastname, :rollno, :status
  acts_as_paranoid :column => 'status', :column_type =>'string', :deleted_value => 'deleted'

belongs_to :gender
belongs_to :branch

def self.only_deleted
  without_paranoid_default_scope.where("#{paranoid_column_reference} IS NOT ?", nil)
end


end
