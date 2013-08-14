class User
  include Mongoid::Document
  ## Database authenticatable
  
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :roles
  
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
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
         :recoverable, :rememberable, :trackable, :validatable
  
  # Roles
  field :role_ids, :type => Array

  before_save :setup_role

  def role?(role)
      if Role.find_by(:name => role.to_s.camelize)
        puts 'found docs with role: ' + role.to_s
        return role
      else
        puts 'did not find any documents with role: ' + role.to_s
        return false
      end
      #return !!self.roles.find_by(:name => role.to_s.camelize)
  end

  # Default role is "Registered"
  def setup_role
    if self[:role_ids].nil? || self[:role_ids].empty?  
      self[:role_ids] = [Role.find_by(:name => "Hauler").id]
    end
  end
end
