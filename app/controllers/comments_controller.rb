class CommentsController < ApplicationController
    before_action :authenticate_user!
    def create
        post = Post.find(params[:post_id])
        comment = post.comments.build(comment_params) 
        comment.user_id = current_user.id
        if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
        else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
        end
    end
    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            redirect_to post_path(@post), notice: 'コメントを削除しました'
        else
            flash.now[:alert] = 'コメント削除に失敗しました'
            render post_path(@post)
        end
    end
    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
