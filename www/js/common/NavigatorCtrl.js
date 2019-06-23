app.controller("NavigatorCtrl", [
  "$scope", "$location", "$timeout", "$http", "$routeParams", "$mdSidenav", function($s, $l, $t, $http, $rp, $mdSidenav) {
    console.log('navis');
    $http.get('/user/show/self').success(function(data) {
      return $s.user = data;
    });
    $s.active = function(url) {
      var i, path;
      path = $l.path() || document.location.pathname;
      if (url !== "/") {
        i = path.indexOf(url);
        return i > -1;
      } else {
        return path === url;
      }
    };
    return $s.navigateTo = function(to, event) {
      console.log(to, event);
      switch (to) {
        case 'Dashboard':
          return $l.path('/dashboard');
        case 'Sheets':
          return $l.path('/sheets');
        case 'Users':
          return $l.path('/users');
        case 'Categories':
          return $l.path('/categories');
        case 'Profile':
          return $l.path('/profile');
        case 'Settings':
          return $l.path('/settings');
        case 'Item':
          return $l.path('/item');
        case 'Unit':
          return $l.path('/unit');
        case 'Transaction':
          return $l.path('/transaction');
        case 'Inventory':
          return $l.path('/inventory');
        case 'Logout':
          return document.location = '/logout';
      }
    };
  }
]);


/*

 $scope.$on('$routeChangeSuccess', function () {
            var items = $scope.items;
            var path = $location.path();

            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                var href = item['href'];
                item['current'] = !!href && href.substring(1) === path;
            }
        });
 */

//# sourceMappingURL=NavigatorCtrl.js.map
