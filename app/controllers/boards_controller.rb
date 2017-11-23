class BoardsController < ApplicationController
  def index
    @boards = Board.all
    @newBoard =Board.new

  end

  def show

  end

  def create
    @board = Board.new(params[:board].permit(:title))
    @board.save
    redirect_to boards_index_path

  end
end
