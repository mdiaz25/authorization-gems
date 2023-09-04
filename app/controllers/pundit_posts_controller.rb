class PunditPostsController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  def index
    @posts = policy_scope(Post)
  end

  def update

  end
end
