class SpecialtyListsController < ApplicationController
  def edit
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
    @keywords = @specialty_list.all_keywords
  end

  def update
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
    @specialty_list.update_attributes(params[:specialty_list])
    @specialty_list.electronics << to_regex(params[:electronics]) unless params[:electronics].blank?
    @specialty_list.mechanical << to_regex(params[:mechanical]) unless params[:mechanical].blank?
    if @specialty_list.save
      flash[:success] = "List Updated!"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  private

  def to_regex(string)
    Regexp.new(string.singularize+"s{0,1}")
  end

  def keyword_exists?(existing_words, keyword)
    return true if existing_words.index(to_regex(keyword))
    false
  end
end
