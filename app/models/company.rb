class Company
  
  # TODO: refactor to use Javascript
  # AGENT.visit("https://www.crunchbase.com/search")
  def self.crunchbase_search(options={})
    name, location, tags = options.values_at(:name, :location, :tags)
  end

  def self.angellist_search(options={})
    name, location, tags = options.values_at(:name, :location, :tags)
    url = "https://angel.co/education/jobs#find/f!%7B%22markets%22%3A%5B%22#{tags.split(",").first}%22%5D%2C%22locations%22%3A%5B%22#{CGI.escape(location)}%22%5D%7D"
    path = (file = Tempfile.new).path
    file.write(`curl #{url}`); file.close
    return `cat #{path}`
  end

  def self.linkedin_search(options={})
    name, location, tags = options.values_at(:name, :location, :tags)
  end

end