class V1::PostsController < BaseApiController
  before_action :authenticate_user_from_token!

  def index
    posts = Post.all
    render json: {data: render_serializable(posts, Post)}
  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save
      render json: {data: render_serializable(post, Post)}
    else
      render_error('api.errors.posts.create', post.errors)
    end
  end

  def update
    post = @current_user.posts.find(params[:id])
    if post.update(post_params)
      render json: {data: render_serializable(post, Post)}
    else
      render_error('api.errors.posts.update', post.errors)
    end
  end

  def destroy
    post = @current_user.posts.find(params[:id])
    post.destroy
    head :ok
  end

  protected
  def post_params
    params.require(:post).permit(:title, :body)
  end
end