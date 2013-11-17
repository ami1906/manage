module StudentsHelper
  # Display active image if the record is a active record else display inactive image
  def status_column record, column
    record.status.nil? ? image_tag("active.png") : image_tag("inactive.png")
  end

end
