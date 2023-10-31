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
      redirect_to pundit_posts_path
    else

    end
  end

  private

  def post_params
    params.permit(:title, :content, :published).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:title, :content, :published)
  end
end
