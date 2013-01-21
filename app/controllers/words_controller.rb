class WordsController < ApplicationController
  def index
    @words = Word.find(:all,:order => 'lower(word) asc')
  end

  def create
     @word = Word.new(params[:word])
     if @word.save
       flash[:notice] = "Successfully created post."
       @words = Word.where("category_id = ?", @word.category_id).order('lower(word) asc')
       render :partial => "main/word_list"
     else
       render :action => 'index'
     end
  end


  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      @words = Word.where("category_id = ?", @word.category_id).order('lower(word) asc')
      render :partial => "main/word_list"
    else
      render :action => 'index'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:notice] = "Successfully destroyed post."
    @words = Word.where("category_id = ?", @word.category_id).order('lower(word) asc')
    render :partial => "main/word_list"
  end

end
