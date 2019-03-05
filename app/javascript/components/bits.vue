<template>
  <div>
    <div class="pull-right">
      <div @click="newBit = !newBit" class="btn" style="background:#24B4F8">
        New Bit
      </div>
    </div>
    <div v-if="newBit" class="card" style="width: 70% !important;margin-top: 5%;;margin-left: 15%;background:#f5f5f5">
      <input v-model="newBitContent" style="height:100px;"/>
      <div style="display:flex">
        <div @click="submitNewBit" class="btn" style="background:#24B4F8;width:50%">Submit</div>
        <div @click="newBit = !newBit" class="btn" style="background:red;width:50%">Cancel</div>
      </div>
    </div>
    <div v-for="bit in bits[0]">
      <div style="width: 70% !important;margin-top: 5%;;margin-left: 15%;background:#f5f5f5"class="card bitcard">
        <div id="bit-header" style="margin-left:2%;margin-top:3%;display: flex;">
          <div id="circle" :style="{'background': profile.color}" style="width: 40px;height: 40px;border-radius: 50%;margin-right:5%;margin-left:2%">
            <p style="font-size: 28px;color: white;margin-left: 35%;margin-top: 25%;">{{profile.first_name[0]}}</p>
          </div>
          <h4 style="font-wieght:bold">@{{profile.username}}</h4>
        </div>
        <p style="font-size: 25px;margin-top: 2%;margin-left: 10%;">{{bit.content}}</p>
      </div>
    </div>



  </div>
</template>

<script>
export default {
  props: ["profile"],
  data() {
    return {
      bits: [],
      newBit: false,
      newBitContent: ""
    };
  },
  methods: {
    submitNewBit() {
      var bit = this.bits;
      this.newBit = false;
      var appendBit = {
        id: this.profile.id,
        content: this.newBitContent
      };
      var data = new FormData();
      data.append("bit[profile_id]", this.profile.id);
      data.append("bit[content]", this.newBitContent);

      Rails.ajax({
        url: "/bits",
        type: "POST",
        data: data,
        dataType: "json",
        success(data) {
          bit[0].push(appendBit);
        }
      });
    },
    get_bits() {
      var id = this.profile.id;
      Rails.ajax({
        url: "/bits/get_bits",
        type: "GET",
        data: id,
        dataType: "json",
        success(data) {}
      });
    }
  },
  mounted() {
    var bits = this.bits;
    var data = new FormData();
    var id = this.profile.id;
    Rails.ajax({
      url: "/bits/get_bits",
      type: "GET",
      data: id,
      dataType: "json",
      success(data) {
        console.log(data);
        bits.push(data);
      }
    });
  }
};
</script>

<style scoped>
.card .bitcard {
}

.row {
  display: inline-flex;
}

.modal-vue .overlay {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-vue .modal {
  position: relative;
  width: 300px;
  z-index: 9999;
  margin: 0 auto;
  padding: 20px 30px;
  background-color: #fff;
}

.modal {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 250px;
  flex-direction: column;
}

.modal-vue .close {
  position: absolute;
  top: 10px;
  right: 10px;
}
</style>