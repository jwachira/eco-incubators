%w(recipes).each do |filename| 
  Capistrano::Configuration.instance.load {load("#{File.dirname(__FILE__)}/#{filename}.rb")}
end

# Capistrano overrides both load and require so it’s probably best to just use load
Dir["#{File.dirname(__FILE__)}/utils/*.rb"].each { |lib|
  load lib
}