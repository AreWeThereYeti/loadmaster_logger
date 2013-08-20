json.array!(@mobile_devices) do |mobile_device|
  json.extract! mobile_device, 
  json.url mobile_device_url(mobile_device, format: :json)
end