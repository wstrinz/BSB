require File.join(File.dirname(__FILE__), *%w[server])
run Sinatra::Application.new
