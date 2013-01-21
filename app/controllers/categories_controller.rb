class CategoriesController < ApplicationController

  def index
  end

  def new
    @category = Category.new
  end

  def create
     @category = Category.new(params[:category])
     @category.user_id = current_user.id
     if @category.save
       flash[:notice] = "Successfully created post."
       @categories = Category.all
       render :partial => "main/category_list"
     else
       render :action => 'index'
     end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated post."
      @categories = Category.all
      render :partial => "main/category_list"
    else
      render :action => 'index'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed post."
    @categories = Category.all
    render :partial => "main/category_list"
  end

  def show
    @words = Word.where("words.category_id = ?",params[:id]).order('lower(word) asc')
    @category = Category.find(params[:id])
    render 'main/words'
  end

end
