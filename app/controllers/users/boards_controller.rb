class Users::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :set_board, only: [:edit, :destroy]
  # prepend_view_path "app/views/boards"
  before_action :set_board, only: [:edit, :destroy]

  def edit
    render "You Suck" unless current_user = @board.user
  end

  def update
    @board.update(board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:description, :price, :category, :photo, :photo_cache)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def set_categories
    @categories = Board::CATEGORIES
  end

end

