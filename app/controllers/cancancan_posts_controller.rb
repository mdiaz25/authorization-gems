class CanCanCanPostsController < ApplicationController
  load_and_authorize_resource class: Post
  def index
    @posts = @posts # no deberiamos de hacer nada aca porque es SSR
    # render json: { posts: @posts } # si fuera API
  end

  def update
    if @post.update(posts_params)

    else

    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content, :author_id)
  end
end
