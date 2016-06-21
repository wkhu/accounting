app.controller "SignupCtrl", [
  "$scope"
  "TOAST"
  "$http"
  "$window"
  ($s, Toast, $http, $window) ->
    propName = (prop) ->
      for i of prop
        return i
      false

    $s.user =
      firstName: ''
      lastName: ''
      username: ''
      email: ''
      password: ''
      confirmPassword: ''
      
    $s.signup = ->
      $http
        .post '/signup', $s.user
        .success (data) ->
          $window.location.href = '/'
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



    $s.pattern = /^.+@.+\..+$/
]