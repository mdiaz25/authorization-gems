class CancancanPostsController < ApplicationController
  load_and_authorize_resource class: Post, instance_name: :post, param_method: :post_params

  def index
    # @index
  end

  def create
    if @post.save
      redirect_to cancancan_posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    debugger
    @post.update(post_params)
    redirect_to cancancan_posts_path
  end

  def destroy
    @post.destroy

    redirect_to cancancan_posts_path
  end

  private

  def post_params
    params.permit(:title, :content, :user_id, :published).merge(user_id: current_user.id)
  end
end
