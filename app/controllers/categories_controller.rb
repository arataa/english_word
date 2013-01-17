class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
     @category = Category.new(params[:category])
     if @category.save
       flash[:notice] = "Successfully created post."
       @categories = Category.all
       render :partial => "main/category_list"
     else
       render :action => 'index'
     end
  end

  def update
    @category = Category.find(params[:category])
    if @post.update_attributes(params[:category])
      flash[:notice] = "Successfully updated post."
      @categories = Categories.all
      render :partial => "main/category_list"
    else
      render :action => 'index'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed post."
    @categories = Categories.all
    render :partial => "main/category_list"
  end

  def show
    @category = Category.find(params[:id])
  end


end
