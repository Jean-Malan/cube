class Profile < ApplicationRecord
  has_friendship

  mount_uploader :avatar, AvatarUploader
  belongs_to :user

  def build_request(from, to)
    binding.pry
    @sender = Profile.find(from)
    @recipient = Profile.find(to)

    @sender.friend_request(@recipient)
  end

end
