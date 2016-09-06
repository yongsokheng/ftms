class Admin::OrganizationChartsController < ApplicationController
  load_and_authorize_resource class: false

  def index
    @locations = Location.includes :manager

    add_breadcrumb_index "organization_charts"
  end
end
