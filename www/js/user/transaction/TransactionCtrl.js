app.controller("TransactionCtrl", [
  "$scope", "$http", "$mdSidenav", "$q", "$timeout", "$mdEditDialog", "$mdDialog", function($s, $http, $mdSidenav, $q, $timeout, $mdEditDialog, $mdDialog) {
    var list, reInit;
    console.log("transactions");
    $s.query = {
      order: 'date',
      limit: 10,
      page: 1
    };
    $s.limits = [10, 20, 30];
    reInit = function() {
      $s.transaction = {};
      $s.transactionForm.$setPristine();
      return $s.transactionForm.$setUntouched();
    };
    list = function() {
      console.log($s.query, 'params');
      return $http.get('/transaction/list', {
        params: $s.query
      }).success(function(result) {
        console.log(result, 'list');
        if (result) {
          $s.transactions = result;
        }
        return console.log($s.transactions, 'transactions');
      });
    };
    list();
    $s.add = function() {
      console.log($s.transaction, 'add');
      return $http.post('/transaction/create', $s.transaction).success(function(data) {
        reInit();
        return list();
      }).error(function(err) {
        reInit();
        return Toast(err.message);
      });
    };
    $s.editTransaction = function(event, transaction) {
      console.log(event, transaction, 'evitem');
      return $mdDialog.show({
        controller: 'transactionEditCtrl',
        template: JST['user/transaction/transactionEdit.html'](),
        targetEvent: event,
        locals: {
          transaction: transaction,
          units: $s.units,
          items: $s.items
        },
        clickOutsideToClose: true
      }).then(function(answer) {
        console.log(answer, 'answer');
        return list();
      });
    };
    $s.selected = [];
    $s.options = {
      boundaryLinks: true,
      largeEditDialog: false,
      pageSelector: true,
      rowSelection: true
    };
    $http.get('/item/list').success(function(result) {
      console.log(result, 'item');
      if (result) {
        return $s.items = result.data;
      }
    });
    $http.get('/unit/list').success(function(result) {
      console.log(result, 'unit');
      if (result) {
        return $s.units = result.data;
      }
    });
    $s.onReorder = function(order) {
      console.log(order, 'order');
      $s.query = angular.extend({}, $s.query, {
        order: order
      });
      console.log($s.query, 'onreorder');
      return $s.list();
    };
    $s.onPaginate = function(page, limit) {
      console.log(page, limit, 'pagelim');
      $s.query = angular.extend({}, $s.query, {
        page: page,
        limit: limit
      });
      console.log($s.query, 'onpaginate');
      return $s.list();
    };
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    $s.loadStuff = function() {
      $s.promise = $timeout((function() {}), 2000);
    };
    $s.logItem = function(item) {
      console.log(item.name, 'was selected');
    };
    return $s.$watch('transaction.item', function(updated) {
      if (updated) {
        return $http.get('/item/show/' + updated).success(function(result) {
          console.log(result, 'unitWatch');
          if (result) {
            $s.transaction.price = result.price;
            $s.transaction.unit = result.unit.unitName;
            return console.log($s.transaction, 'transaction up');
          }
        });
      }
    }, true);
  }
]).controller('transactionEditCtrl', [
  '$scope', '$mdDialog', '$http', 'transaction', 'units', 'items', function($s, $mdDialog, $http, transaction, units, items) {
    $s.transaction = transaction;
    console.log($s.transaction, 'trans');
    $s.transaction.date = new Date($s.transaction.date);
    $s.units = units;
    $s.items = items;
    $s.$watch('transaction.item.id', function(updated) {
      console.log(updated, 'updated');
      if (updated) {
        return $http.get('/item/show/' + updated).success(function(result) {
          console.log(result, 'unitWatch');
          if (result) {
            $s.transaction.price = result.price;
            $s.unit = result.unit.unitName;
            return console.log($s.transaction, 'transaction up');
          }
        });
      }
    }, true);
    $s.closeDialog = function() {
      console.log('close');
      return $mdDialog.cancel();
    };
    return $s.save = function() {
      return console.log($s.transaction, 'transaction');
    };
  }
]);

//# sourceMappingURL=TransactionCtrl.js.map
