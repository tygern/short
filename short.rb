require "sinatra"
require "haml"
require "rack-flash"
require_relative "lib/url_entry"

class Short < Sinatra::Base
  enable :sessions
  use Rack::Flash

  get "/login" do
    haml :login, locals: {notice: flash[:notice], user: nil}
  end

  get "/logout" do
    logout
    redirect to "/login"
  end

  post "/user" do
    login(params[:user])

    redirect to "/"
  end

  get "/" do
    require_login

    haml :index, locals: {notice: flash[:notice], user: current_user}
  end

  get "/:shortened" do
    url_entry = UrlEntry.find(params[:shortened])

    if url_entry
      redirect to(url_entry.original_url)
    else
      flash[:notice] = "Url not found"
      redirect to "/"
    end

  end

  post "/url" do
    require_login
    begin
    uri = URI::parse(params[:original_url])
    rescue URI::InvalidURIError
      flash[:notice] = "#{params[:original_url]} is not a valid url."
    end


    if uri.kind_of? URI::HTTP or uri.kind_of? URI::HTTPS
      entry = UrlEntry.new(uri.to_s)
      shortened = entry.save
      flash[:notice] = "#{entry.original_url} shortened to #{request.base_url}/#{shortened}"
    else
      flash[:notice] = "#{params[:original_url]} is not a valid url."
    end

    redirect to "/"
  end

  private

  def require_login
    redirect to "/login" unless current_user
  end

  def login(user)
    session[:user] = user
  end

  def logout
    session[:user] = nil
  end

  def current_user
    session[:user] if session[:user] && !session[:user].empty?
  end
end