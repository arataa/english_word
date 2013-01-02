class MainController < ApplicationController

  def index
    @word = Word.find(:all)
  end

  def update_word
logger.debug request
    english          = params[:english]
logger.debug english
    english_meaning  = params[:english_meaning]
    japanese_meaning = params[:japanese_meaning]
    Word.update(english, english_meaning, japanese_meaning)
#render :partial => 'suggests/friends_list', :object => @users
    render :nothing => true
  end

end
