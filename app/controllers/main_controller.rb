class MainController < ApplicationController

  def index
    redirect_to "/login" if current_user.nil?
    @categories = Category.all
  end

  def search_word
    @words = Word.where("word LIKE ?",'%' + params[:word] + '%').order("lower(word)")
    render :partial => "main/word_list"
  end

  def get_words
    @words = Word.find(:all,:order => 'lower(word) asc')
    render :json => @words
  end

  def update_words
    words = params[:_json]
    Word.updates(words)
    render :text => "true"
  end

end
