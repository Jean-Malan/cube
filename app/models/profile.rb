class Profile < ApplicationRecord
  has_friendship

  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  has_many :bits

  def build_request(from, to)
    @sender = Profile.find(from)
    @recipient = Profile.find(to)

    @sender.friend_request(@recipient)
  end

  def accepts_friend_requests(s, r)
    sender = Profile.find(s)
    recipient = profile.find(r)

    recipient.accept_request(sender)

  end

  def self.verify_user_profile(id)
    User.find(id).profiles.count > 0 ? true : false
  end

  def self.get_friend_ids(id) 
    @ids = []
    profile = Profile.where(user_id: id)[0]
    profile.friends.map{|f| @ids << f.id}
    @ids = @ids.uniq

  end

  def self.get_pending_friend_ids(id) 
    ids = []
    profile = User.find(id).profiles[0]
    profile.pending_friends.map{|f| ids << f.id}
    ids = ids.uniq
  end

end
