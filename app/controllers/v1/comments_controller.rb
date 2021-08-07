class V1::CommentsController < BaseApiController
  before_action :authenticate_user_from_token!, only: [:create, :update, :destroy]
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]

  def index
    comments = @post.comments
    render json: {data: render_serializable(comments)}
  end

  def create
    comment = @post.comments.new(comment_params.merge(user: @current_user))
    if comment.save
      render json: {data: render_serializable(comment, Comment)}
    else
      render_error('api.errors.comments.create', comment.errors)
    end
  end

  def update
    if @comment.update(comment_params)
      render json: {data: render_serializable(@comment, Comment)}
    else
      render_error('api.errors.comments.update', @comment.errors)
    end
  end

  def destroy
    @comment.destroy
    head :ok
  end

  protected
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end
end