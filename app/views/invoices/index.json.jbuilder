json.array!(@invoices) do |invoice|
  json.extract! invoice, :timestamp, :hauler_id, :trips, :price, :costumer, :description, :due_date, :cvr, :commentary, :end_note, :invoice_number, :sales_taxes
  json.url invoice_url(invoice, format: :json)
end