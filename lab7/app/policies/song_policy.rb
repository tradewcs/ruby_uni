class SongPolicy < ApplicationPolicy
  # "user" is the currently logged-in user (nil if not logged in)
  # "record" is the Song instance

  def index?
    true  # Anyone can see the song list
  end

  def show?
    true  # Anyone can view a song
  end

  def create?
    user.present? # Only logged-in users can create
  end

  def update?
    user.present? # Only logged-in users can update
  end

  def destroy?
    user.present? # Only logged-in users can destroy
  end
end
