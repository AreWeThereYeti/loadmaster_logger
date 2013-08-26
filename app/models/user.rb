class User
  include Mongoid::Document
  ## Database authenticatable
  
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :roles
  
  field :username,           :type => String, :default => ""
  field :email,              :type => String, :default => "" 
  field :encrypted_password, :type => String, :default => ""
  field :login
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  
  field :devices,           :type => Array
  
  field :access_token,        :type => String
  
  field :user_id,           :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  
  # Roles
  field :role_id, :type => String

  before_save :setup_role
  after_save :setup_user_id
  
  def email_required?
    false
  end

  # def role?(role,role_id)
  #   return Role.find_by(:name => role.to_s.camelize).id.to_s == role_id
  # end
  
  # def role?(role,user_role_id)
  #   puts 'role: '
  #   puts role
  #   puts 'user role'
  #   user_role=Role.find_by(:name => role.to_s.camelize)
  #   puts user_role.id
  #   puts 'current_user id:'
  #   puts user_role_id
  #   
  #   if !!user_role
  #     Role.find_by(:name => role.to_s.camelize).id.to_s == user_role_id
  #   else
  #     false
  #   end
  # end
  
  def role?(role,role_id)
    puts 'role ran with id'
    puts role_id.to_s
    puts self.role_id
    role_id=Role.where(:name => role.to_s.camelize)
    puts role_id.first.id.to_s
    puts self
    
    for attribute in self.attributes
      puts attribute
    end
    if !!role_id
      puts 'role_id defined...'
      return self.role_id == role_id.first.id.to_s
    else
      false
    end
  end

  # Default role is "Hauler"
  def setup_role
    if self[:role_id].nil? || self[:role_id].empty?  
      self[:role_id] = Role.find_by(:name => "Hauler").id
    end
  end
  
  def setup_user_id
    if !self[:user_id]
      self[:user_id] = self[:id]
      self.update
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login).downcase
      where(conditions).where('$or' => [ {:username => /^#{Regexp.escape(login)}$/i}, {:email => /^#{Regexp.escape(login)}$/i} ]).first
    else
      where(conditions).first
    end
  end
  
end
