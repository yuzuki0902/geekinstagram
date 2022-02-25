class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
        if params[:search] == nil
            @posts= Post.all
            elsif params[:search] == ''
                @posts= Post.all
            else
            @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%')
        end
    end
    def new
        @post = Post.new
    end
    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
        end
        
        def show
            @id = params[:id]
            @post = Post.find_by(id: params[:id])
            @user = User.find_by(id: @post.user_id)
            @post = Post.includes(:user).find(params[:id])
            @comments = @post.comments.includes(:user).all
            @comment  = @post.comments.build(user_id: current_user.id) if current_user
        end
        
        def edit
            @post = Post.find(params[:id])
        end
        def update
            post = Post.find(params[:id])
            if post.update(post_params)
                redirect_to :action => "show", :id => post.id
            else
                redirect_to :action => "new"
            end
        end
        def destroy
            post = Post.find(params[:id])
            post.destroy
            redirect_to action: :index
        end
        private
        def post_params
        params.require(:post).permit(:body, :image)
    end
end
