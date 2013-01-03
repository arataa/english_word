class MainController < ApplicationController

  def index
    @words = Word.find(:all,:order => 'lower(english) asc')
  end

  def update_word
    english          = params[:english]
    english_meaning  = params[:english_meaning]
    japanese_meaning = params[:japanese_meaning]

    return if ( english.length == 0) 
    Word.update(english, english_meaning, japanese_meaning)
    @words = Word.find(:all,:order => 'lower(english) asc')
    render :partial => "main/list"
  end

  def delete_word
    Word.where("id = ?",params[:id]).delete_all
    @words = Word.find(:all,:order => 'lower(english) asc')
    render :partial => "main/list"
  end

  def search_word
    @words = Word.where("english LIKE ?",'%' + params[:english] + '%').order("lower(english)")
    render :partial => "main/list"
  end

  def get_words
    @words = Word.find(:all,:order => 'lower(english) asc')
    render :json => @words
  end

end
