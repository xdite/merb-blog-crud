class Blogs < Application
  # provides :xml, :yaml, :js

  def index
    @posts = Post.all
    display @posts
  end

  def show
    @post = Post.get(params[:id])
    raise NotFound unless @post
    display @post
  end

  def new
    only_provides :html
    @post = Post.new
    display @post
  end

  def edit
    only_provides :html
    @post = Post.get(params[:id])
    raise NotFound unless @post
    display @post
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect url(:blog, @post), :message => {:notice => "Post was successfully created"}
    else
      message[:error] = "Post failed to be created"
      render :new
    end
  end

  def update
    @post = Post.get(params[:id])
    raise NotFound unless @post
    if @post.update_attributes(params[:post])
       redirect url(:blog,@post)
    else
      display @post, :edit
    end
  end

  def destroy
    @post = Post.get(params[:id])
    raise NotFound unless @post
    if @post.destroy
      redirect resource(:blogs)
    else
      raise InternalServerError
    end
  end

end # Post
