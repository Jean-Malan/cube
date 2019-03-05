<template>
  <div class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-8">
              <div class="card">
                <div class="card-header card-header-icon card-header-primary">
                  <div class="card-icon">
                    <i class="fa fa-person"></i>
                  </div>
                  <h4 class="card-title">Edit Profile -
                    <small class="category">Complete your profile</small>
                  </h4>
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
                           <input type="image" name="pic">
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
                    <button @click="submitProfile" type="submit" class="btn btn-rose pull-right">Update Profile</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card card-profile">
                <div class="card-avatar">
                  <a href="#pablo">
                    <img class="img"  />
                  </a>
                </div>
                <div class="card-body">
                  <h6 class="card-category text-gray">CEO / Co-Founder</h6>
                  <h4 class="card-title">{{first_name}} {{last_name}}</h4>
                  <p class="card-description">
                    {{about}}
                  </p>
                  <a href="#pablo" class="btn btn-rose btn-round">Follow</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
</template>

<script>
export default {
  props: ["id"],
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
      avatar: ""
    };
  },
  methods: {
    submitProfile() {
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
        dataType: "json"
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