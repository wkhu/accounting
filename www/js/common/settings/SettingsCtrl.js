app.controller("SettingsCtrl", [
  "$scope", "$mdSidenav", "$http", "TOAST", function($s, $mdSidenav, $http, Toast) {
    var reInit;
    console.log("User settings");
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    reInit = function() {
      $s.user = {};
      $s.passwordForm.$setPristine();
      return $s.passwordForm.$setUntouched();
    };
    return $s.save = function() {
      console.log($s.user, 'pass');
      return $http.put('/user/changePassword', $s.user).success(function(data) {
        console.log(data, 'data');
        reInit();
        return Toast(data.message);
      }).error(function(err) {
        console.log(err, 'err');
        reInit();
        return Toast(err);
      });
    };
  }
]);

//# sourceMappingURL=SettingsCtrl.js.map
