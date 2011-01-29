def fakes
  Pathname.new(File.dirname(__FILE__) + "/../fakes")
end

def fake(name, options = {})
  options.symbolize_keys!

  method = options.delete(:method) || :get
  
  options[:query] ||= {}
  options[:query][:key] ||= "FAKE"
  query = options[:query].map { |k,v| "#{k}=#{v}" }.join("&")

  base = "http://api.stackoverflow.com/1.0/"
  path = fakes + name
  # i.e. /badges/name => /badges/name
  #      /badges => /badges/index
  file = if File.file?(path)
    path
  else
    path + "index"
  end

  stub_request(method, base + name + "?" + query).
    to_return(:body => File.read(file))
end