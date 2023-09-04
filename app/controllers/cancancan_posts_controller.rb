class CancancanPostsController < ApplicationController
  load_and_authorize_resource class: Post, instance_name: :post, param_method: :post_params
  def index
    @posts = @posts # no deberiamos de hacer nada aca porque es SSR
  end

  def create
    if @post.save
      flash[:notice] = 'Successfully created'
      redirect_to cancancan_posts_path
    else
      flash[:alert] = 'Error creating post'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(posts_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:alert] = 'Error updating post'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:alert] = 'Error destroying post'
    end

    redirect_to cancancan_posts_path
  end

  private

  def post_params
    params.permit(:title, :content, :user_id)
  end
end
