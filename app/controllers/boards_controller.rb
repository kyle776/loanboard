class BoardsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @board = @user.boards.new(board_params)
    if @board.save
      redirect_to boards_path
    else
      render :new
    end
  end

  def index
    @boards = Board.all
  end

  def new
    @user = current_user
    @board = @user.boards.new
  end

  def show
    @board = Board.find(params[:id])
  end


  private

  def board_params
    params.require(:board).permit(:description, :price, :category, :photo, :photo_cache)
  end

  def build_planner(past_weeks=1, seldate=Date.today, future_weeks=4)
    start_date = (seldate - (past_weeks * 7).days).monday
    end_date = start_date + ((past_weeks + 1 + future_weeks) * 7).days - 1.day
    result = (start_date .. end_date).to_a.map do |date|
      [date, @board.availabilities.where("date = ?", date).first]
    end
    result.each_slice(7).to_a.transpose
  end
end
