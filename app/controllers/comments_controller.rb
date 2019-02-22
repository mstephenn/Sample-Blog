class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    post = Post.find(params[:post_id])
    @comments = post.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.build(user_id: current_user.id)
  end

  # GET /comments/1/edit
  def edit
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to([@comment.post, @comment], notice: 'Comment was successfully created.') }
        format.js {}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to([@comment.post, @comment], notice: 'Comment was successfully updated.') }
        format.js {}
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post }
      format.json { head :no_content }
    end
  end

  private    
    def comment_params
      params.require(:comment).permit(:comment_text, :post_id, :user_id)
    end
end
