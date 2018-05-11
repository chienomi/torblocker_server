class RegistrationsController < ApplicationController
  skip_before_filter :require_no_authentication

  protected
end
