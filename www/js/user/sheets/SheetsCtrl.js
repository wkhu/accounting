app.controller("SheetsCtrl", [
  "$scope", "$http", "$mdDialog", "$location", "$mdSidenav", function($s, $http, $mdDialog, $l, $mdSidenav) {
    console.log('wtf');
    $s.list = function() {
      return $http.get('/sheet/list').success(function(data) {
        var sudlanan;
        console.log(data, 'data');
        if (data) {
          sudlanan = [];
          data.forEach(function(s) {
            s.background = "green";
            s.size = 60;
            return sudlanan.push(s);
          });
          return $s.sheets = sudlanan;
        }
      });
    };
    $s.list();
    $s.fab = 24;
    $s.showAdd = function(ev) {
      $s.sheet = {
        name: '',
        description: ''
      };
      return $mdDialog.show({
        controller: 'DialogCtrl',
        template: '<md-dialog aria-label="Add sheet dialog">' + "  <md-dialog-content layout='column' class='md-dialog-content'>" + '    <h2> Add Sheet </h2>' + '    <md-input-container>' + '      <label> Name </label>' + "      <input type='text' ng-model='sheet.name'></input>" + '    </md-input-container>' + '    <md-input-container>' + '      <label> Description </label>' + "      <input type='text' ng-model='sheet.description'></input>" + '    </md-input-container>' + '  </md-dialog-content>' + '  <md-dialog-actions>' + '    <md-button ng-click="closeDialog()" class="md-primary">' + '      Close Dialog' + '    </md-button>' + '    <md-button ng-click="addSheet()" class="md-primary">' + '      Add Sheet' + '    </md-button>' + '  </md-dialog-actions>' + '</md-dialog>',
        targetEvent: ev
      }).then(function(answer) {
        console.log(answer, 'answer');
        $s.list();
        return $s.alert = 'You said the information was "' + answer + '".';
      }, function() {
        console.log(answer, 'answer2');
        return $s.alert = 'You cancelled the dialog.';
      });
    };
    $s.navigateTo = function(to, event) {
      console.log(to, event, 'navi');
      return $l.path('/sheet/' + to + '/expenses/');
    };
    $s.$watch('sheets', function(updated) {
      console.log(updated, 'updated');
      return $s.sheets = updated;
    }, true);
    return $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
  }
]).controller('DialogCtrl', [
  '$scope', '$mdDialog', '$http', function($s, $mdDialog, $http) {
    $s.closeDialog = function() {
      return $mdDialog.hide();
    };
    return $s.addSheet = function() {
      console.log($s.sheet, 'add');
      return $http.post('/sheet/create', $s.sheet).success(function(data) {
        return $mdDialog.hide(data);
      }).error(function(err) {
        return $mdDialog.hide();
      });
    };
  }
]);

//# sourceMappingURL=SheetsCtrl.js.map
