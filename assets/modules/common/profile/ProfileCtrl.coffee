app.controller "ProfileCtrl",[
  "$scope"
  "$mdSidenav"
  "$http"
  "TOAST"
  ($s, $mdSidenav, $http, Toast)->
    console.log "User settings"
    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()

    propName = (prop) ->
      for i of prop
        return i
      false

    $s.pattern = /^.+@.+\..+$/
    
    $http.get('/user/show/self')
    .success (data) ->
      $s.user = data
      console.log $s.user,'user'

    $s.save = ->
      $http
        .put '/user/update', $s.user
        .success (data) ->
          Toast "Profile updated successfully."
        .error (err) ->
          console.log err,'err'
          alert = propName err.invalidAttributes
          console.log alert,'alert'
          switch alert
            when 'username'
              if err.invalidAttributes.username[0].rule is "unique"
                message = "A user with that username already exists: " + '"' + err.invalidAttributes.username[0].value + '"'
                Toast message
            when 'email'
              if err.invalidAttributes.email[0].rule is "unique"
                message = "A user with that email already exists: " + '"' + err.invalidAttributes.email[0].value + '"'
                Toast message
]