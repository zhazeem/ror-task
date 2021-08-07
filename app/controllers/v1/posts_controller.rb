class V1::PostsController < BaseApiController
  before_action :authenticate_user_from_token!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:update, :destroy]

  def index
    posts = Post.all
    render json: {data: render_serializable(posts)}
  end

  def show
    post = Post.find(params[:id])
    render json: {data: render_serializable(post, Post)}
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
    if @post.update(post_params)
      render json: {data: render_serializable(post, Post)}
    else
      render_error('api.errors.posts.update', post.errors)
    end
  end

  def destroy
    @post.destroy
    head :ok
  end

  protected
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = @current_user.posts.find(params[:id])
  end
end