app.controller("CategoriesCtrl", [
  "$scope", "$http", "$mdSidenav", function($s, $http, $mdSidenav) {
    console.log("categories");
    $s.query = {
      order: '',
      limit: 10,
      page: 1
    };
    $s.limits = [10, 20, 30];
    $s.selected = [];
    $s.options = {
      boundaryLinks: true,
      largeEditDialog: false,
      pageSelector: true,
      rowSelection: true
    };
    $s.list = function() {
      return $http.get('/category/list', {
        params: $s.query
      }).success(function(data) {
        console.log(data, 'data');
        if (data) {
          return $s.categories = data;
        }
      });
    };
    $s.list();
    $s.category = {
      name: '',
      description: '',
      add: function() {
        console.log($s.category, 'add');
        return $http.post('/category/create', {
          name: this.name,
          description: this.description
        }).success(function(data) {
          return $s.list();
        }).error(function(err) {
          return Toast(err.message);
        });
      }
    };
    $s.onReorder = function(order) {
      console.log(order, 'order');
      $s.query = angular.extend({}, $s.query, {
        order: order
      });
      console.log($s.query);
      return $s.list();
    };
    $s.onPaginate = function(page, limit) {
      $s.query = angular.extend({}, $s.query, {
        page: page,
        limit: limit
      });
      console.log($s.query);
      return $s.list();
    };
    return $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
  }
]);

//# sourceMappingURL=CategoriesCtrl.js.map
