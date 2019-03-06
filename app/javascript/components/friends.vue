<template>
<div>
  <div v-if="current_user == userId">
    <div class="row" style="margin-left: 20%;">
      <h2 @click="getAllFriends" class="btn btn-sm col-md-3" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;background:#24B4F8">
        All Friends
      </h2>
      <h2 @click="getPendingRequests" class="btn btn-sm col-md-3" :style="{'background-color': pendingColor}" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;">
        Pending Requests
      </h2>
      <h2 @click="getFriendRequests" class="btn btn-sm col-md-3" :style="{'background-color': requestColor}" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;">
        Friend Requests
      </h2>
    </div>
  </div>

  <div style="grid-template-columns: 33% 33% 3%;display: grid;margin-left: 10%;">
    <div v-for="user in users[0]">
      <div class="card card-body" style=" background:#eee;height:260px;width:300px;overflow-y:scroll;">
        <div 
          id="circle" 
          :style="{'background-color': user.color}"
          style= "width: 60px;height: 60px;border-radius: 50%;margin-top: 5%;margin-left: 38%;">
          <p @click="goToProfile(user.id)"
            style="font-size: 38px;text-align:center;cursor:pointer;color: white;margin-left: 0%;margin-top: 35%;font-weight: bold;">
            {{user.username[0].toUpperCase()}}
          </p>
        </div>
        <h2 style="font-size:30px;font-weight:bold;text-align: center;">
          {{user.username}}
        </h2>
        <div v-if="displayingRequested" @click="acceptFriendRequest(user.id)" class="btn btn-primary" style="background-color:#3c4858;">
          Accept Request 
        </div>
      </div>
    </div>
  </div>
</div>

</template>

<script>
export default {
  props: ["userId", "limit", "current_user"],
  data() {
    return {
      current_user_id: this.userId,
      friendLimit: this.limit,
      users: [],
      displayFriends: true,
      displayPending: false,
      displayingRequested: false
    };
  },
  methods: {
    goToProfile(id) {
      window.location.href = "/profiles/" + id;
    },
    addFriend(from, to) {
      var data = new FormData();
      data.append("profile[current_user]", from);
      data.append("profile[friend_user]", to);

      console.log(to);
      console.log(from);
      Rails.ajax({
        url: "/profiles/build_friend_request",
        type: "POST",
        data: data,
        dataType: "json",
        success(data) {
          console.log(data);
        }
      });
    },
    getPendingRequests() {
      this.users = [];
      this.displayFriends = false;
      this.displayPending = true;
      this.displayingRequested = false;
      var user = this.users;
      var data = new FormData();
      Rails.ajax({
        url: "/profiles/get_all_pending_requests",
        type: "GET",
        data: data,
        dataType: "json",
        success(data) {
          console.log(data);
          user.push(data);
        }
      });
    },
    getAllFriends() {
      this.users = [];
      var user = this.users;
      var id = this.userId;
      Rails.ajax({
        url: "/profiles/get_friends",
        type: "GET",
        data: id,
        dataType: "json",
        success(data) {
          user.push(data);
          console.log(data);
        }
      });
    },
    acceptFriendRequest(from) {
      var data = new FormData();
      data.append("profile[sender]", from);
      Rails.ajax({
        url: "/profiles/handle_friend_request",
        type: "POST",
        data: data,
        dataType: "json",
        success(data) {
          user.push(data);
          this.getFriendRequests();
        }
      });
    },
    getFriendRequests() {
      this.users = [];
      this.displayFriends = false;
      this.displayPending = false;
      this.displayingRequested = true;
      var user = this.users;
      Rails.ajax({
        url: "/profiles/get_all_friend_requests",
        type: "GET",
        dataType: "json",
        success(data) {
          console.log(data);
          user.push(data);
        }
      });
    }
  },
  computed: {
    allColor() {
      this.displayFriends ? "#24B4F8" : "#919191";
    },
    pendingColor() {
      this.displayPending ? "#24B4F8" : "#919191";
    },
    requestColor() {
      this.displayingRequested ? "#24B4F8" : "#919191";
    }
  },
  mounted() {
    var id = this.userId;

    var user = this.users;
    Rails.ajax({
      url: "/profiles/get_friends",
      type: "GET",
      data: id,
      dataType: "json",
      success(data) {
        console.log(data);
        user.push(data);
      }
    });
  }
};
</script>

<style scoped>
</style>