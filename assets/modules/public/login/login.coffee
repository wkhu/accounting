app.controller "LoginCtrl", [
  "$scope"
  "TOAST"
  "$http"
  "$window"
  ($s, Toast, $http, $window) ->
    $s.user =
      username: ''
      password: ''
    $s.login = ->
      console.log 'asa man'
      $http
        .post '/login', $s.user
        .success (data) ->
          console.log data,'data'
          # $window.location.href = '/'
          if data
            if data.message
              Toast data.message
            else if data
              $window.location.href = '/'
        .error (err) ->
          console.log err, 'err'
          Toast err.message
    #   facebook: ->
    #     $http.get('/facebook')

    # $s.changed = ->
    #   console.log $s.error, 'error'
    #   $s.error  = false if $s.error
    #   console.log $s.error, '$s.error'
]