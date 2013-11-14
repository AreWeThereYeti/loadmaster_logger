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
    css_class = column == sort_column ? "current #{sort_direction} float-right white" : nil
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
  
  def format_date(date)
    date=date.localtime
    append_zero(date.day)+'.'+append_zero(date.month)+'.'+append_zero(date.year)+' '+append_zero(date.hour)+':'+append_zero(date.min)
  end
  
  def format_date_only_date(date)
    date=date.localtime
    append_zero(date.day)+'.'+append_zero(date.month)+'.'+append_zero(date.year)
  end
  
  def append_zero(number)
    if number<10
      '0'+number.to_s
    else
      number.to_s
    end
  end
  
  def user_property(property)
    if !!current_user[property]
      current_user[property].to_s
    else
      ''
    end
  end
  
  def param_undefined(param)
    param.nil? || param.class==NilClass || param=="undefined" || param=="null" || (param.class==String && param.empty?) ? true : false
  end
  
  def get_ids_from_obj(obj)
    ids=[]
    obj.each do |item|
      ids.push(item.id.to_s)
    end
    return ids
  end
  
  def diff_timestamps_in_secs(time1,time2)
    diff=Time.diff(time1,time2, '%y, %d and %h:%m:%s')
    
    d = diff[:day]==0 ? '' : diff[:day].to_s+'d'
  
    h = diff[:hour]==0 ? '' : diff[:hour].to_s+'t'
    
    if diff[:minute]==0 && diff[:second]>0
      m = '1m'
    elsif diff[:minute]==0 && diff[:second]==0
      m = ''
    else
      m=diff[:minute].to_s+'m'
    end
    
    return d + ' ' + h + ' ' + m
  end
  
end
