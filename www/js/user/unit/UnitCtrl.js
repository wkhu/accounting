app.controller("UnitCtrl", [
  "$scope", "$http", "$mdSidenav", "TOAST", "$mdEditDialog", function($s, $http, $mdSidenav, Toast, $mdEditDialog) {
    var createFilterFor, list, querySearch, reInit, unitNames;
    console.log("units");
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
      rowSelection: false
    };
    unitNames = [];
    list = function() {
      return $http.get('/unit/list', {
        params: $s.query
      }).success(function(results) {
        var units;
        console.log(results, 'results');
        if (results) {
          $s.units = results;
          units = $s.units.data;
          unitNames = units.map(function(unit) {
            return {
              value: unit.unitName.toLowerCase(),
              display: unit.unitName
            };
          });
          return console.log(unitNames, units, $s.units, 'unitcheck');
        }
      });
    };
    list();
    reInit = function() {
      $s.unit = {};
      $s.unitForm.$setPristine();
      return $s.unitForm.$setUntouched();
    };
    querySearch = function(query) {
      var results;
      console.log(query, 'querySearch');
      console.log(unitNames, 'unitNames');
      results = query ? unitNames.filter(createFilterFor(query)) : [];
      console.log(results, 'querysearch results');
      return results;
    };
    createFilterFor = function(query) {
      var lowercaseQuery;
      console.log(query, 'createfilterfor');
      lowercaseQuery = angular.lowercase(query);
      console.log(lowercaseQuery, 'lowercase');
      return function(unit) {
        console.log(unit, 'createfilterfor unit');
        return unit.value.indexOf(lowercaseQuery) === 0;
      };
    };
    $s.searchText = null;
    $s.selectedItem = null;
    $s.querySearch = querySearch;
    $s.unit = {};
    $s.addUnit = function() {
      console.log($s.unit, 'add');
      return $http.post('/unit/create', $s.unit).success(function(data) {
        console.log(data, 'data');
        list();
        return reInit();
      }).error(function(err) {
        var message;
        console.log(err, 'err');
        reInit();
        if (err.invalidAttributes.unitName[0].rule === "unique") {
          message = "A record with that Unit Name already exists: " + '"' + err.invalidAttributes.unitName[0].value + '"';
          return Toast(message);
        }
      });
    };
    $s.editUnit = function(event, unit) {
      var editDialog, promise;
      event.stopPropagation();
      editDialog = {
        modelValue: unit.unitName,
        save: function(input) {
          unit.unitName = input.$modelValue;
          return $http.put('/unit/update', unit).success(function(err, data) {
            return console.log(err, data, 'errdata');
          });
        },
        targetEvent: event
      };
      promise = $mdEditDialog.small(editDialog);
      return promise.then(function(ctrl) {
        var input;
        return input = ctrl.getInput();
      });
    };
    $s["delete"] = function(id) {
      return $http["delete"]('/unit/delete/' + id).success(function(result) {
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

//# sourceMappingURL=UnitCtrl.js.map
