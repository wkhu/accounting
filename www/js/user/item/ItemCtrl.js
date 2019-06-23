app.controller("ItemCtrl", [
  "$scope", "$http", "$mdSidenav", "$mdEditDialog", "$mdDialog", function($s, $http, $mdSidenav, $mdEditDialog, $mdDialog) {
    var $touched, list, reInit;
    console.log("Items");
    $s.query = {
      order: '',
      limit: 10,
      page: 1
    };
    $s.limits = [10, 20, 30];
    $s.selected = [];
    $s.options = {
      boundaryLinks: true,
      pageSelector: true,
      rowSelection: false
    };
    list = function() {
      return $http.get('/item/list', {
        params: $s.query
      }).success(function(results) {
        console.log(results, 'results');
        if (results) {
          return $s.items = results;
        }
      });
    };
    list();
    $touched = false;
    reInit = function() {
      $s.item = {};
      $s.itemForm.$setPristine();
      return $s.itemForm.$setUntouched();
    };
    $http.get('/unit/list').success(function(result) {
      console.log(result, 'unit');
      if (result) {
        return $s.units = result.data;
      }
    });
    $s.item = {};
    $s.addItem = function() {
      console.log($s.item, 'add');
      return $http.post('/item/create', $s.item).success(function(data) {
        list();
        return reInit();
      }).error(function(err) {
        reInit();
        return Toast(err.message);
      });
    };
    $s["delete"] = function(id) {
      console.log(id, 'id');
      return $http["delete"]('/item/delete/' + id).success(function(result) {
        console.log(result, 'deleted');
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
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    return $s.editItem = function(event, item) {
      console.log(event, item, 'evitem');
      return $mdDialog.show({
        controller: 'itemEditCtrl',
        template: JST['user/item/itemEdit.html'](),
        targetEvent: event,
        locals: {
          item: item,
          units: $s.units
        },
        clickOutsideToClose: true
      }).then(function(answer) {
        console.log(answer, 'answer');
        list();
        return $s.alert = 'You said the information was "' + answer + '".';
      }, function() {
        console.log('cancel');
        return $s.alert = 'You cancelled the dialog.';
      });
    };
  }
]).controller('itemEditCtrl', [
  '$scope', '$mdDialog', '$http', 'item', 'units', function($s, $mdDialog, $http, item, units) {
    $s.item = {};
    $s.item = item;
    console.log($s.item, 'item');
    $s.units = units;
    $s.closeDialog = function() {
      console.log('close');
      $s.item = item;
      console.log($s.item, 'item');
      return $mdDialog.cancel();
    };
    return $s.save = function() {
      $s.item.unit = $s.item.unit.id;
      console.log($s.item, 'item');
      return $http.put('/item/update', $s.item).success(function(data) {
        console.log(data, 'success');
        return $mdDialog.hide(data);
      }).error(function(err) {
        return $mdDialog.hide();
      });
    };
  }
]);

//# sourceMappingURL=ItemCtrl.js.map
