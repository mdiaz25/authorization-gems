class CancancanPostsController < ApplicationController
  load_and_authorize_resource class: Post, instance_name: :post, param_method: :post_params

  def create
    @post.save
    redirect_to cancancan_posts_path
  end

  def update
    @post.update(update_params)
    redirect_to cancancan_posts_path
  end

  def destroy
    @post.destroy
    redirect_to cancancan_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id, published: !params[:draft].present?)
  end

  def update_params
    params.require(:post).permit(:title, :content).merge(published: true)
  end
end
