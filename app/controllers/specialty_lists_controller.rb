class SpecialtyListsController < ApplicationController
  def edit
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
    @keywords = @specialty_list.all_keywords
  end

  def update
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
    @new_word = params[:electronics]
    @specialty_list.electronics << to_regex(params[:electronics]) unless params[:electronics].blank?
    @specialty_list.mechanical << to_regex(params[:mechanical]) unless params[:mechanical].blank?
    @specialty_list.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
    @specialty_list.electronics.slice!(params[:delete_id].to_i)
    @specialty_list.save
    respond_to do |format|
      format.js
    end
  end

  private

  def to_regex(string)
    Regexp.new(string.singularize+"s{0,1}")
  end
end
