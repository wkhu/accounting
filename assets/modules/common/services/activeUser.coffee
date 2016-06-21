# angular
#   .module('app')
app.factory 'USER', [
  "$http"
  ($http) ->
    (callback) ->
      # Get the logged din users info
      $http.get('/user/show/self').success (user) ->
        console.log 'active user: ' + user
        callback user
]
