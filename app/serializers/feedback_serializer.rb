class FeedbackSerializer < ActiveModel::Serializer
  attributes :message, :language, :tone, :user_id

  def language
    object.language.abbr 
  end

  def tone
    object.tone.emotion if object.tone
  end

end
