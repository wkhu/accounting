app.controller("LoginCtrl", [
  "$scope", "TOAST", "$http", "$window", function($s, Toast, $http, $window) {
    $s.user = {
      username: '',
      password: ''
    };
    return $s.login = function() {
      console.log('asa man');
      return $http.post('/login', $s.user).success(function(data) {
        console.log(data, 'login data');
        if (data) {
          if (data.message) {
            return Toast(data.message);
          } else if (data) {
            return $window.location.href = '/';
          }
        }
      }).error(function(err) {
        console.log(err, 'err');
        return Toast(err.message);
      });
    };
  }
]);

//# sourceMappingURL=login.js.map
