require "sinatra"
require "haml"

class Short < Sinatra::Base
  enable :sessions

  get "/" do
    url = session[:url] || "http://www.example.com"
    haml :index, locals: {url: url}
  end

  post "/url" do
    p params[:url]
    session[:url] = params[:url]

    redirect to("/")
  end
end