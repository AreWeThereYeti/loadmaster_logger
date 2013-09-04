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
  
  search_in :price, :invoice_number, :costumer, :cvr, :due_date, :timestamp
  
end
