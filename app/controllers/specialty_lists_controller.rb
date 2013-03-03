class SpecialtyListsController < ApplicationController
  before_filter :get_specialty_list
  def edit
    @keywords = @specialty_list.all_keywords
  end

  def update
    @new_word = params[:electronics]
    @specialty_list.electronics << to_regex(params[:electronics]) unless params[:electronics].blank?
    @specialty_list.mechanical << to_regex(params[:mechanical]) unless params[:mechanical].blank?
    @specialty_list.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @specialty_list.electronics.slice!(params[:delete_id].to_i)
    @specialty_list.save
    respond_to do |format|
      format.js
    end
  end

  private

  def get_specialty_list
    @specialty_list = SpecialtyList.find_by_owner_id(current_user.id)
  end

  def to_regex(string)
    Regexp.new(string.singularize+"s{0,1}")
  end
end
