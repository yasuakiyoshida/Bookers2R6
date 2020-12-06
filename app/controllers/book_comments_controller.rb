class BookCommentsController < ApplicationController
	before_action :authenticate_user!

  # Ajaxでいいねするのでredirect_to削除
	def create
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		@book_comment.save
	end

	def destroy
		@book = Book.find(params[:book_id])
  	book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
		@book_comments = @book.book_comments
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
