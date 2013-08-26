module ApplicationHelper
  
  def ll_user_show_path 
    if current_user.role? :admin, current_user.role_id
      '/admin/users/'+current_user.id 
    else 
      '/user/'+current_user.id
    end
  end
  
end
