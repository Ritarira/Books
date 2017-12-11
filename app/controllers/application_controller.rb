class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    respond_to do |type|
      type.html { render template: "errors/error_404", status: :not_found }
      type.json  { render nothing: true, status: :not_found }
    end
  end
end
