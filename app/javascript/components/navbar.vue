<template>
  <div>
    <nav class="navbar navbar-expand-lg" style="background: linear-gradient(45deg, #7f2fe0 0%, #4c83e7 50%, #00e6e3 100%);">
  <div class="container">
    <div class="navbar-translate">
      <a class="navbar-brand" href="#0">Brand</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="sr-only">Toggle navigation</span>
        <span class="navbar-toggler-icon"></span>
        <span class="navbar-toggler-icon"></span>
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <a href="#pablo" class="nav-link">link</a>
        </li>
        <li class="nav-item">
          <!-- <% if user_signed_in? %>
            <%= link_to('Logout', destroy_user_session_path, method: :delete) %>        
          <% else %>
            <%= link_to('Login', new_user_session_path)  %>  
          <% end %> -->
        </li>
      </ul>
      <form class="form-inline ml-auto">
        <div class="form-group has-white">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-white btn-raised btn-fab btn-round">
          <i class="material-icons">search</i>
        </button>
      </form>
    </div>
  </div>
</nav>

  </div>
</template>

<script>
export default {
  
};
</script>

<style scoped>
</style>