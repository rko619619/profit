# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_filter do
    if request.ssl? && Rails.env.production?
      redirect_to :protocol => 'http://', :status => :moved_permanently
    end
  end

end
