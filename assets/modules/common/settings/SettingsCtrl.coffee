app.controller "SettingsCtrl",[
  "$scope"
  "$mdSidenav"
  "$http"
  "TOAST"
  ($s, $mdSidenav, $http, Toast)->
    console.log "User settings"
    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()

    # $http.get('/user/show/self')
    # .success (data) ->
    #   $s.user = data
    #   console.log $s.user,'user'
    reInit = ->
      $s.user = {}
      $s.passwordForm.$setPristine()
      $s.passwordForm.$setUntouched()

    $s.save = ->
      console.log $s.user, 'pass'

      $http
        .put '/user/changePassword', $s.user
        .success (data) ->
          console.log data,'data'
          reInit()
          Toast data.message
        .error (err) ->
          console.log err,'err'
          reInit()
          Toast err

]