<template>
<div>
  <div class="page-header header-filter" data-parallax="true"></div>
    <div class="main main-raised">
      <div class="profile-content">
        <div class="container" style="height:100%">

          <div class="row">
            <div class="col-md-6 ml-auto mr-auto">
              <div class="profile">
                <div id="circle" :style="{'background': profile.color}" style="width: 100px;height: 100px;border-radius: 50%;margin-left: -40%;margin-top: 2%;">
                  <p style="margin-left: 40%;padding-top: 40%;font-size: 48px;color: white;">{{profile.first_name[0]}}</p>
                </div>
                <div class="name">
                  <h1 class="title" style="margin-top: -10%;">{{profile.username}}</h1>
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
                <ul class="nav nav-pills nav-pills-icons justify-content-center" role="tablist">
                  <li class="nav-item" style="margin-right:25%">
                    <i @click="displayFriends = !displayFriends" class="fa fa-users "></i> Friends
                  </li>
                  <li class="nav-item" style="margin-right: 25%;">
                    <i class="fa fa-twitter"></i> Bits
                  </li>
                  <li class="nav-item">
                    <i class="fa fa-photo"></i> Photos
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
        <div class="profile-content">
          <div class="container" style="height:100%">
            <div v-if="displayFriends == true">
              <friends :userId="profile.id" :limit="limit"></friends>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import friends from "./friends.vue";

export default {
  props: ["profile", "current_user"],
  components: { friends },
  data() {
    return {
      displayFriends: false,
      showAllFriends: true,
      showAllRequests: false,
      limit: "all"
    };
  },
  methods: {
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
  }
};
</script>

<style scoped>
.underline {
  text-decoration: underline;
}
</style>