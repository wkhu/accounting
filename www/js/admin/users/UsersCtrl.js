app.controller("UsersCtrl", [
  "$scope", "$http", "$mdSidenav", function($s, $http, $mdSidenav) {
    var list;
    console.log("users");
    $s.query = {
      order: '',
      limit: 5,
      page: 1
    };
    $s.limits = [5, 10, 15];
    $s.selected = [];
    $s.options = {
      boundaryLinks: true,
      largeEditDialog: false,
      pageSelector: true,
      rowSelection: false
    };
    list = function() {
      return $http.get('/user/list').success(function(data) {
        console.log(data, 'user data');
        if (data) {
          $s.users = data;
          return console.log($s.users, 'scope userss');
        }
      });
    };
    list();
    $s["delete"] = function(id) {
      return $http["delete"]('/user/delete/' + id).success(function(result) {
        return list();
      });
    };
    $s.onReorder = function(order) {
      console.log(order, 'order');
      $s.query = angular.extend({}, $s.query, {
        order: order
      });
      console.log($s.query);
      return list();
    };
    $s.onPaginate = function(page, limit) {
      $s.query = angular.extend({}, $s.query, {
        page: page,
        limit: limit
      });
      console.log($s.query);
      return list();
    };
    return $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
  }
]);

//# sourceMappingURL=UsersCtrl.js.map
