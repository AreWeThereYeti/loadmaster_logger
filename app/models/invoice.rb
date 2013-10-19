class Invoice
  include Mongoid::Document
  include Mongoid::Search
  
  has_and_belongs_to_many :users
  
  field :timestamp,         :type => Time
  field :user_id,           :type => String 
  field :trips,             :type => Array 
  field :price,             :type => String 
  field :costumer,          :type => String
  field :description ,      :type => String 
  field :due_date,          :type => Time 
  field :cvr,               :type => Integer 
  field :commentary,        :type => String 
  field :end_note,          :type => String 
  field :invoice_number,    :type => Integer 
  field :sales_taxes,       :type => Integer
  
  
  field :costumer_name,           :type => String 
  field :costumer_contact_name,   :type => String 
  field :costumer_address_street, :type => String 
  field :costumer_postal_code,    :type => String 
  field :costumer_city,           :type => String 
  
  field :company_name,            :type => String 
  field :company_street,          :type => String
  field :company_phone,           :type => String 
  field :company_phone_mobile,    :type => String 
  field :company_bank_reg_nr,     :type => String 
  field :company_bank_account_nr,     :type => String 
  
  field :netto_price,             :type => String 
  field :brutto_price,            :type => String 
  field :taxes,                   :type => String 
  
    validates_presence_of :cvr, :invoice_number, :costumer_name, :costumer_contact_name, :costumer_address_street, :costumer_postal_code, :costumer_city, :company_name, :company_street, :company_phone, :company_bank_reg_nr, :company_bank_account_nr 

  search_in :price, :invoice_number, :costumer, :cvr, :description, :due_date, :timestamp, :costumer_name, :costumer_address_street, :costumer_postal_code,:costumer_city,:company_name,:company_street, :company_phone
  
end
