app.controller("DashboardCtrl", [
  "$scope", "$mdSidenav", "$http", "USER", function($s, $mdSidenav, $http, USER) {
    var computeStock, groupBy;
    console.log("dashboard");
    $s.query = {};
    $s.chosenItem = null;
    groupBy = function(array, f) {
      var groups;
      groups = {};
      console.log(array, 'array');
      array.forEach(function(item) {
        var group;
        group = JSON.stringify(f(item));
        console.log(group, 'stringified');
        groups[group] = groups[group] || [];
        console.log(groups[group], 'groups[group]');
        return groups[group].push(item);
      });
      console.log(groups, 'objectkeys');
      return Object.keys(groups).map(function(group) {
        console.log(groups[group], group, 'group');
        return groups[group];
      });
    };
    computeStock = function(array) {
      array.forEach(function(group) {
        var stockBalance, stockValue;
        stockBalance = 0;
        stockValue = 0;
        return group.forEach(function(item) {
          var tempBal, tempVal;
          tempBal = item.quantity;
          tempVal = tempBal * item.price;
          if (item.type) {
            stockBalance += tempBal;
            stockValue += tempVal;
          } else {
            stockBalance -= tempBal;
            stockValue -= tempVal;
          }
          item.stockBalance = stockBalance;
          return item.stockValue = stockValue;
        });
      });
      return array;
    };
    USER(function(user) {
      console.log(user, 'user');
      $s.query.user = user.id;
      $s.list = function() {
        console.log($s.query, 'query');
        return $http.get('/transaction/list', {
          params: $s.query
        }).success(function(results) {
          console.log(results, 'results');
          if (results) {
            $s.stocks = computeStock(groupBy(results.data, function(item) {
              console.log(item, 'item');
              return [item.item];
            }));
            return console.log($s.stocks, 'after compute');
          }
        });
      };
      return $s.list();
    });
    $http.get('/item/list').success(function(result) {
      console.log(result, 'item');
      if (result) {
        return $s.items = result.data;
      }
    });
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    return $s.$watch('chosenItem', function(updated) {
      console.log(updated, 'updated');
      if (updated) {
        $s.query.id = updated;
        $s.show = function() {
          console.log($s.query, 'query');
          return $http.get('/transaction/show', {
            params: $s.query
          }).success(function(results) {
            console.log(results, 'results');
            if (results) {
              $s.stocks = computeStock(groupBy(results, function(item) {
                console.log(item, 'item');
                return [item.item];
              }));
              return console.log($s.stocks, 'after compute');
            }
          });
        };
        return $s.show();
      }
    }, true);
  }
]);

//# sourceMappingURL=DashboardCtrl.js.map
