class KeywordsController < ApplicationController

  def index
    @keywords = Keyword.all
  end

  def show
      @keyword = Keyword.find(params[:id])
  end

  def new
    @keyword = Keyword.new
  end

  def edit
    @keyword = Keyword.find(params[:id])
  end

  def create
    @keyword = Keyword.new(keyword_params)

    if @keyword.save
      redirect_to @keyword
    else
      render 'new'
    end
  end

  def update
    @keyword = Keyword.find(params[:id])

    if @keyword.update(keyword_params)
      redirect_to @keyword
    else
      render 'edit'
    end
  end

  private
    def keyword_params
      params.require(:keyword).permit(:text)
    end
end
