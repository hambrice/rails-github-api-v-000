class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = CGI.escape("http://www.localhost:3000/auth")
      state = ('a'..'z').to_a.shuffle[0,8].join
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=repo&state=#{state}"
      redirect_to github_url unless logged_in?
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow
    end

    def logged_in?
      !!session[:token]
    end
end
