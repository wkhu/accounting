app.controller("ProfileCtrl", [
  "$scope", "$mdSidenav", "$http", "TOAST", function($s, $mdSidenav, $http, Toast) {
    var propName;
    console.log("User settings");
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    propName = function(prop) {
      var i;
      for (i in prop) {
        return i;
      }
      return false;
    };
    $s.pattern = /^.+@.+\..+$/;
    $http.get('/user/show/self').success(function(data) {
      $s.user = data;
      return console.log($s.user, 'user');
    });
    return $s.save = function() {
      return $http.put('/user/update', $s.user).success(function(data) {
        return Toast("Profile updated successfully.");
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
  }
]);

//# sourceMappingURL=ProfileCtrl.js.map
