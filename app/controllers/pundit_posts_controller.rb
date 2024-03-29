class PunditPostsController < ApplicationController
  include Pundit::Authorization
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @posts = policy_scope(Post)
  end

  def show
    authorize post
  end

  def edit
    authorize post
  end

  def create
    post = Post.new(create_params)
    authorize post
    post.save
    redirect_to pundit_posts_path
  end

  def update
    authorize post
    post.update(create_params)
    redirect_to pundit_posts_path
  end

  def destroy
    authorize post
    post.destroy
    redirect_to pundit_posts_path
  end

  private

  def create_params
    params.require(:post).permit(:title, :content, :published).merge(user_id: current_user.id, published: !params[:draft].present?)
  end

  def update_params
    params.require(:post).permit(:title, :content)
  end

  def post
    @post ||= Post.find(params[:id])
  end
end
