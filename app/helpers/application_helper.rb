module ApplicationHelper
  
  # def ll_user_show_path 
  #   if current_user.role? :admin, current_user.role_id
  #     '/admin/users/'+current_user.id 
  #   else 
  #     '/user/'+current_user.id
  #   end
  # end
  
  def is_admin
    unless !user_signed_in?
      if current_user.role? :admin, current_user 
        return true
      else
        return false
      end
    end
    return false
  end
  
  def sortable(title, column)
    css_class = column == sort_column ? "current #{sort_direction} float-right" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    #for default last first use:
    #direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    link_to(title, {:sort => column, :direction => direction, :search => params[:search]}) + content_tag(:i, '',:class=>css_class)
  end
  
  def profile_username
    if !current_user.username.empty?
      current_user.username 
    else
      current_user.email
    end
  end
end
