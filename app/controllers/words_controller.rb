class WordsController < ApplicationController
  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      @words = Word.find(:all,:order => 'lower(english) asc')
      render :partial => "main/list"
    else
      render :action => 'index'
    end
  end
end
