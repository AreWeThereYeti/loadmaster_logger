class User
  include Mongoid::Document
  include Mongoid::Search
  
  has_and_belongs_to_many :roles
  has_many :trips
  has_many :invoices
  belongs_to :mobile_devices
  
  
  accepts_nested_attributes_for :roles
  
  before_save :setup_role
  after_save :setup_user_id
  
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
  field :sign_in_count,       :type => Integer, :default => 0
  field :current_sign_in_at,  :type => Time
  field :last_sign_in_at,     :type => Time
  field :current_sign_in_ip,  :type => String
  field :last_sign_in_ip,     :type => String
  
  field :devices,             :type => Array
  
  field :access_token,        :type => String
  
  field :user_id,             :type => String
  
  field :cvr,                 :type => String
  field :company_name,        :type => String
  field :company_street,      :type => String
  field :company_city,        :type => String
  field :company_postal_code, :type => String
  field :phone,               :type => String
  field :phone_mobile,        :type => String
  
  field :bank,                :type => String
  field :bank_reg_nr,         :type => String 
  field :bank_account_nr,     :type => String 

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

  search_in :username, :email, :role_id

  
  def email_required?
    false
  end
  
  def role?(role,role_id)
    role_id=Role.where(:name => role.to_s.camelize)
    if !!role_id
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
    puts 'self.find_first_by_auth_conditions ran'
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.where({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
  
  def self.find_for_database_authentication(warden_conditions)
    puts 'self.find_first_by_auth_conditions ran'
    conditions = warden_conditions.dup
    if login = conditions.delete(:login).downcase
      where(conditions).where('$or' => [ {:username => /^#{Regexp.escape(login)}$/i}, {:email => /^#{Regexp.escape(login)}$/i} ]).first
    else
      where(conditions).first
    end
  end
  
end
