class CancancanPostsController < ApplicationController
  load_and_authorize_resource class: Post, instance_name: :post
  def index
    @posts = @posts # no deberiamos de hacer nada aca porque es SSR
  end

  def update
    if @post.update(posts_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:alert] = 'Error updating post'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
