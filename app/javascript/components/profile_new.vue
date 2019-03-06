<template>
<div>
  <div v-if="incomplete">
    <div class="content" style="margin-left: 25%;">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-8">
            <div class="card">
              <div class="card-header card-header-icon card-header-primary">
                <div class="card-icon">
                  <i class="fa fa-person"></i>
                </div>
                <h4 style="font-size:30px;" class="card-title">Complete your profile</h4>
              </div>
              <div class="card-body">
                <form>
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label class="bmd-label-floating">Username</label>
                        <input v-model="username" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label class="bmd-label-floating">Avatar</label>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label class="bmd-label-floating">Fist Name</label>
                        <input v-model="first_name" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label class="bmd-label-floating">Last Name</label>
                        <input v-model="last_name" type="text" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label class="bmd-label-floating">Adress</label>
                        <input v-model="address" type="text" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label class="bmd-label-floating">City</label>
                        <input v-model="city" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label class="bmd-label-floating">Country</label>
                        <input v-model="country" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label class="bmd-label-floating">Postal Code</label>
                        <input v-model="postal_code" type="text" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label>About Me</label>
                        <div class="form-group">
                          <textarea v-model="about" class="form-control" rows="5"></textarea>
                        </div>
                      </div>
                    </div>
                  </div>
                  <button @click="submitProfile" type="submit" class="btn btn-rose pull-right">Submit Profile</button>
                  <div class="clearfix"></div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div v-if="!incomplete">
    <div @click="redirect" class="btn" style="margin-left:45%;margin-top:20%;width:200px;height:70px;background:#24B4F8;text-align:center"> Go To Profile</div>
  </div>
</div>
</template>

<script>
import FileUpload from "vue-simple-upload/dist/FileUpload";
export default {
  components: { fileupload: FileUpload },
  data() {
    return {
      username: "",
      first_name: "",
      last_name: "",
      address: "",
      city: "",
      country: "",
      country: "",
      postal_code: "",
      about: "",
      avatar: "",
      incomplete: true
    };
  },
  methods: {
    redirect() {
      window.location = "/profiles";
    },
    submitProfile() {
      this.incomplete = false;
      var data = new FormData();
      data.append("profile[first_name]", this.first_name);
      data.append("profile[last_name]", this.last_name);
      data.append("profile[username]", this.username);
      data.append("profile[address]", this.address);
      data.append("profile[city]", this.city);
      data.append("profile[country]", this.country);
      data.append("profile[postal_code]", this.postal_code);
      data.append("profile[about]", this.about);

      Rails.ajax({
        url: "/profiles",
        type: "POST",
        data: data,
        dataType: "json",
        success() {
          incom = false;
        }
      });
    }
  }
};
</script>

<style>
.row {
  margin-top: 3% !important;
}
</style>