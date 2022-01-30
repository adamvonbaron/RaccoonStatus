class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  
  before_action :authenticate_user!, unless: -> { current_page?(root_path) }
end
