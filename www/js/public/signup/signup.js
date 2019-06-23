app.controller("SignupCtrl", [
  "$scope", "TOAST", "$http", "$window", function($s, Toast, $http, $window) {
    var propName;
    propName = function(prop) {
      var i;
      for (i in prop) {
        return i;
      }
      return false;
    };
    $s.user = {
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      password: '',
      confirmPassword: ''
    };
    $s.signup = function() {
      return $http.post('/signup', $s.user).success(function(data) {
        return $window.location.href = '/';
      }).error(function(err) {
        var alert, message;
        console.log(err, 'err');
        alert = propName(err.invalidAttributes);
        console.log(alert, 'alert');
        switch (alert) {
          case 'username':
            if (err.invalidAttributes.username[0].rule === "unique") {
              message = "A user with that username already exists: " + '"' + err.invalidAttributes.username[0].value + '"';
              return Toast(message);
            }
            break;
          case 'email':
            if (err.invalidAttributes.email[0].rule === "unique") {
              message = "A user with that email already exists: " + '"' + err.invalidAttributes.email[0].value + '"';
              return Toast(message);
            }
        }
      });
    };
    return $s.pattern = /^.+@.+\..+$/;
  }
]);

//# sourceMappingURL=signup.js.map
