/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from "vue/dist/vue.esm"
import Profile from "../components/profile"
import ProfileNew from "../components/profile_new"

window.store = {}

document.addEventListener("DOMContentLoaded", () => {
  var element = document.querySelector("#profile")
  if (element != undefined) {
    window.store.profile = JSON.parse(element.dataset.profile)
    window.store.current_user = JSON.parse(element.dataset.currentUser)
    const app = new Vue({
      el: element,
      data: window.store,
      template: "<Profile :profile='profile' :current_user='current_user' />",
      components: { Profile }
    })
  }
})

document.addEventListener("DOMContentLoaded", () => {
  var element = document.querySelector("#profileNew")
  if (element != undefined) {
    const app = new Vue({
      el: element,
      data: window.store,
      template: "<ProfileNew />",
      components: { ProfileNew }
    })
  }
})
