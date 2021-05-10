class PostsController < ApplicationController
  def index
  	@posts = PostsService.listAll
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv, filename: "posts_#{Date.today}.csv" }
    end
  end

  def show
  	@post = PostsService.findPostById(params[:id])
  end

  def new
  	@post = PostsService.newPost
  end

  def create_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :new
    else
      redirect_to :action => "create_confirm", title: @post.title, description: @post.description
    end
  end

  def create_confirm
    @title = params[:title]
    @description = params[:description]
    @post = Post.new(title: @title, description: @description)
  end

  def create
  	savePost = PostsService.createPost(post_params)

  	if savePost
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  def edit
  	@post = PostsService.findPostById(params[:id])
  end

  def edit_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :new
    else
      redirect_to :action => "update_confirm", title: @post.title, description: @post.description, state: @post.status,id: @post.id
    end
  end

  def update_confirm
    @id = params[:id]
    @title = params[:title]
    @description = params[:description]
    if params[:state] == ""  || params[:state] == "0"
  		@status = 0
  	else
  		@status = 1
  	end
    @post = Post.new(title: @title, description: @description, status: @status, id: @id)
  end

  def post_update
  	updatePost = PostsService.updatePost(post_params)

  	if updatePost
  		redirect_to posts_path
  	else
  		render :edit
  	end 
  end

  def destroy
  	PostsService.destroyPost(params[:id])
  	redirect_to root_path
  end

  def search_post
    searchKey = params[:search]
    @posts = PostsService.searchPost(searchKey)
    render :index
  end

  def import
  	Post.import(params[:file])
  	redirect_to root_url, notice: "Successfully Uploaded!!!"
  end

  def new_release
  	@posts = PostsService.listAll
	respond_to do |format|
	   	format.html
	    format.js
	end
  end

  private
    def post_params
    params.require(:post).permit(:id, :title, :description, :status)
  end
end
