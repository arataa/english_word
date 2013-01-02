class MainController < ApplicationController

  def index
    @words = Word.find(:all)
  end

  def update_word
    english          = params[:english]
    english_meaning  = params[:english_meaning]
    japanese_meaning = params[:japanese_meaning]

    return if ( english.length == 0) 
    Word.update(english, english_meaning, japanese_meaning)
    @words = Word.find(:all)
    render :partial => "main/list"
  end

  def delete_word
    Word.where("id = ?",params[:id]).delete_all
    @words = Word.find(:all)
    render :partial => "main/list"
  end

  def search_word
    @words = Word.where("english LIKE ?",'%' + params[:english] + '%')
    render :partial => "main/list"
  end

end
