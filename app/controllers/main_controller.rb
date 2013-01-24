class MainController < ApplicationController

  def index
    redirect_to "/login" if current_user.nil?
    @categories = Category.where("user_id = ?",current_user.id)
  end

  def search_word
    @words = Word.where("word LIKE ?",'%' + params[:word] + '%').order("lower(word)")
    render :partial => "main/word_list"
  end

  def update_words
    categoriesAndWords = params[:_json]
    
    Word.updates(words)
    render :text => "true"
  end

  def get_categroies_words
    user       = User.authenticate params[:email], params[:password]
    words      = Word.joins(:category).where("categories.user_id = ?",user.id)
    categories = Category.where("categories.user_id = ?",user.id)
    categoriesAndWords = {:categories => categories, :words => words}
    render :json => categoriesAndWords
  end

end
