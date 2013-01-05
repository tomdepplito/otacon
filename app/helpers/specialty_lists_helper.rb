module SpecialtyListsHelper
  def unregex(regex)
    unless regex.blank?
      regex.source.gsub(/\W|\d/, '')
    else
      ""
    end
  end
end
