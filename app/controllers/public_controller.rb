class PublicController < ApplicationController
  before_action :authenticate_user!
end
