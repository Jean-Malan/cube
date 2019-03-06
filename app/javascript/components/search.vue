<template>
  <div>
    <Dropdown
      :options="profiles"
      v-on:selected="getProfiles"
      :disabled="false"
      placeholder="Search for new freiends">
  </Dropdown>
  </div>
</template>

<script>
import Dropdown from "vue-simple-search-dropdown";
export default {
  components: { Dropdown },
  props: ["profiles"],
  data() {
    return {
      users: this.profiles
    };
  },
  methods: {
    getProfiles(event) {
      console.log(event.id);
      console.log(event.name);
      if (event.id != undefined) {
        window.location = "/profiles/" + event.id;
      } else {
        return null;
      }
    }
  }
};
</script>

<style scoped>
</style>