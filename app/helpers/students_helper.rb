module StudentsHelper
def status_column record, column
    record.status.nil? ? image_tag("active.png") : image_tag("inactive.png")
  end

end
