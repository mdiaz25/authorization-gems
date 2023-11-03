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
    if @post.update(update_params)
      redirect_to cancancan_posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to cancancan_posts_path
    else

    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id, published: !params[:draft].present?)
  end

  def update_params
    params.require(:post).permit(:title, :content).merge(published: true)
  end
end
