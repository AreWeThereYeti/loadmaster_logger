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

  search_in :price, :invoice_number, :costumer, :cvr
  
end
