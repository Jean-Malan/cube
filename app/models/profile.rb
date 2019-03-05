class Profile < ApplicationRecord
  has_friendship

  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  has_many :bits

  def build_request(from, to)
    binding.pry
    @sender = Profile.find(from)
    @recipient = Profile.find(to)

    @sender.friend_request(@recipient)
  end

  def accepts_friend_requests(s, r)
    binding.pry
    sender = Profile.find(s)
    recipient = profile.find(r)

    recipient.accept_request(sender)

  end


end
