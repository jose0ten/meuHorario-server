class ApplicationController < ActionController::Base
  require 'open-uri'

  protect_from_forgery with: :null_session
end
