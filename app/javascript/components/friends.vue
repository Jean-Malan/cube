<template>
  <div>
     <div class="row" style="margin-left: 20%;">
      <h2 @click="getAllFriends" class="btn btn-danger btn-sm col-md-3" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;">
        All Friends
      </h2>
      <h2 @click="getPendingRequests" class="btn btn-warning btn-sm col-md-3" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;">
        Pending Requests
      </h2>
      <h2 @click="getFriendRequests" class="btn btn-alert btn-sm col-md-3" style="cursor: pointer;font-size: 18px;font-weight: bold;margin-right: 2%;margin-top: 5%;">
        Friend Requests
      </h2>
    </div>

    <div style="grid-template-columns: 33% 33% 3%;display: grid;margin-left: 10%;">
      <div v-for="user in users[0]">
        <div class="card card-body" style=" background:#eee;height:260px;width:300px;overflow-y:scroll;">
            <div 
              id="circle" 
              :style="{'background-color': user.color}"
              style= "width: 60px;height: 60px;border-radius: 50%;margin-top: 5%;margin-left: 38%;">
              
              <p @click="goToProfile(user.id)"
                style="font-size: 38px;text-align:center;cursor:pointer;color: white;margin-left: 8%;margin-top: 35%;font-weight: bold;">
                {{user.username[0].toUpperCase()}}
              </p>

            </div>
            <h2 style="font-size:30px;font-weight:bold;text-align: center;">{{user.username}}</h2>
            <div v-if="displayFriends" @click="addFriend(current_user_id, user.id)" class="btn btn-primary" style="background-color:#3c4858;">Add Friend </div>
            <div v-if="displayPending" @click="CancelRequest(current_user_id, user.id)" class="btn btn-primary" style="background-color:#3c4858;">Cancel Request </div>
            <div v-if="displayingRequested" @click="acceptRequest(current_user_id, user.id)" class="btn btn-primary" style="background-color:#3c4858;">Accept Request </div>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["userId", "limit"],
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
      this.displayFriends = true;
      this.displayPending = false;
      this.displayingRequested = false;
      var user = this.users;
      Rails.ajax({
        url: "/profiles/get_all_profiles",
        type: "GET",
        dataType: "json",
        success(data) {
          console.log(data);
          user.push(data);
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
  mounted() {
    var user = this.users;
    Rails.ajax({
      url: "/profiles/get_all_profiles",
      type: "GET",
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