class PunditPostsController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  def index
    @posts = policy_scope(Post)
  end

  def update
    authorize post
    if post.update(create_params)
      redirect_to pundit_posts_path
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    authorize post
  end

  def create
    post = Post.new(create_params)
    if post.save
      redirect_to pundit_posts_path
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to pundit_posts_path
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:post).permit(:title, :content)
  end

  def post
    @post ||= Post.find(params[:id])
  end
end
