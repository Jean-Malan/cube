<template>
<div>
  <div class="page-header header-filter" data-parallax="true"></div>
    <div class="main main-raised">
      <div class="profile-content">
        <div class="container" style="height:100%">
          <div v-if="profile.id != current_user">
            <div v-if="notFriends">
              <div @click="addFriend(current_user, profile.id)" class="btn pull-right" style="background:#24B4F8">Add Friend</div>
            </div>
            <div v-if="friendsPending">
              <div class="btn pull-right" style="background:#24B4F8">Request Pending</div>
            </div>
          </div>  
          <div class="row">
            <div class="col-md-6 ml-auto mr-auto">
              <div class="profile">
                <div class="profile-pic">
                  <div id="circle" :style="{'background': profile.color}" style="width: 200px;height: 200px;margin-left: -40%;margin-top: 2%;background: rgb(165, 250, 223);;">
                    <p style="margin-left: 35%;font-weight: bold;padding-top: 44%;font-size: 78px;color: white;">{{profile.first_name[0].toUpperCase()}}</p>
                  </div>
                </div>
                <div class="name" style="margin-left: 10%;">
                  <span><h1 class="title" style="margin-top: -23%;">{{profile.username}}</h1><i v-if="profile.id != current_user" @click="editProfile(profile.id)" style="cursor:pointer" class="fa fa-edit"></i></span>
                  <h6>{{profile.first_name}}{{profile.last_name}}</h6>
                  <h6>{{profile.country}}, {{profile.city}}, {{profile.country}}</h6>
                  <i class="fa fa-dribbble"></i>
                  <i class="fa fa-twitter"></i>
                  <i class="fa fa-pinterest"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="description text-center">
            <p>{{profile.about}}</p>
          </div>

          <div class="row" style="padding-bottom: 30px;">
            <div class="col-md-6 ml-auto mr-auto">
              <div class="profile-tabs">
                <ul class="nav nav-pills nav-pills-icons justify-content-center" style="margin-left: 20%;margin-top: 5%;" role="tablist">
                  <li class="nav-item" style="margin-left:5%;margin-right:35%">
                    <i @click="showFriendList" class="fa fa-users "></i> Friends
                  </li>
                  <li class="nav-item" style="margin-right: 25%;">
                    <i @click="showBits" class="fa fa-twitter"></i> Bits
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="page-header header-filter" data-parallax="true"></div>
      <div class="main main-raised">
        <div class="profile-content" style="padding:1%">
          <div class="container" style="height:100%;min-height:300px">
            <div v-if="displayFriends">
              <Friends :userId="profile.id" :current_user="current_user"  :limit="limit"></Friends>
            </div>
            <div v-if="displayBits">
              <Bits :profile="profile" :current_user="current_user" :limit="limit"></Bits>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Friends from "./friends.vue";
import Bits from "./bits.vue";

export default {
  props: ["profile", "current_user", "friends", "pending_friends"],
  components: { Friends, Bits },
  data() {
    return {
      displayFriends: false,
      showAllFriends: true,
      showAllRequests: false,
      limit: "all",
      displayBits: true,
      friendList: this.friends,
      pendingFriendList: this.pending_friends
    };
  },
  methods: {
    editProfile(id) {
      window.location = "/profiles/" + id + "/edit";
    },
    addFriend(from, to) {
      var profile_id = to;
      var data = new FormData();
      data.append("profile[to]", to);
      var fl = this.pendingFriendList;
      console.log(to);
      console.log(from);
      Rails.ajax({
        url: "/profiles/add_friend",
        type: "POST",
        data: data,
        dataType: "json",
        success() {
          fl.push(profile_id);
        }
      });
    },
    showFriendList() {
      this.displayBits = false;
      this.displayFriends = true;
    },
    showBits() {
      this.displayBits = true;
      this.displayFriends = false;
    },
    showFriends() {
      this.showAllRequests = false;
      this.showAllFriends = true;
      this.limit = "all";
    },
    showRequests() {
      this.showAllRequests = true;
      this.showAllFriends = false;
      this.limit = "requests";
    },
    allFriendunderlined() {
      if (this.showAllFriends == true) {
        return "underline";
      }
    },
    requestUnderlined() {
      if (this.showAllRequests == true) {
        return "underline";
      }
    }
  },
  computed: {
    notFriends() {
      var id = this.profile.id;
      if (this.friendList.indexOf(id) < 0 && this.friendsPending == false) {
        return true;
      } else {
        return false;
      }
    },
    friendsPending() {
      if (this.pendingFriendList.indexOf(this.profile.id) >= 0) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>

<style scoped>
.underline {
  text-decoration: underline;
}
</style>