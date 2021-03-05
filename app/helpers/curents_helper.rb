module CurentsHelper
  def find_relationships id
    @current_user = current_user.active_relationships.find_by(followed_id: id)
  end
end
