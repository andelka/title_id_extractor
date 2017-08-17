require 'csv'

class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]

  def index
    @keywords = Keyword.all

    respond_to do |format|
      format.html
      format.csv { send_data Keyword.to_csv, filename: "Item_list_#{Date.today}.csv" }
    end
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
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'The Item list was successfully created.' }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'The Item list was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'The Item list was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_keyword
     @keyword = Keyword.find(params[:id])
    end

    def keyword_params
      params.require(:keyword).permit(:text)
    end
end
