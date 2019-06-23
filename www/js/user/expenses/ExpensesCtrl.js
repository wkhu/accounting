app.controller("ExpensesCtrl", [
  "$scope", "$http", "$mdSidenav", "$routeParams", "$q", "$timeout", "$mdEditDialog", function($s, $http, $mdSidenav, $rp, $q, $timeout, $mdEditDialog) {
    console.log("expenses", $rp);
    $s.query = {
      order: 'date',
      limit: 50,
      page: 1,
      id: $rp.id
    };
    $s.limits = [50, 100, 150];
    $s.list = function() {
      return $http.get('/expense/list', {
        params: $s.query
      }).success(function(result) {
        console.log(result, 'list');
        if (result) {
          $s.sum = 0;
          $s.expenses = result;
          $s.expenses.data.forEach(function(t) {
            return $s.sum += t.total;
          });
        }
        return console.log($s.expenses, 'expenses');
      });
    };
    $s.list();
    $http.get('/sheet/show', {
      params: $rp
    }).success(function(result) {
      console.log(result, 'sheet');
      if (result) {
        return $s.sheet = result;
      }
    });
    $http.get('/category/list').success(function(result) {
      console.log(result, 'category');
      if (result) {
        return $s.categories = result.data;
      }
    });
    $s.selected = [];
    $s.options = {
      boundaryLinks: true,
      largeEditDialog: false,
      pageSelector: true,
      rowSelection: true
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
    $s.expense = {
      date: null,
      item: '',
      quantity: null,
      price: null,
      total: null,
      category: '',
      sheet: $rp.id,
      add: function() {
        $s.expense.total = this.quantity * this.price;
        console.log($s.expense, 'add');
        return $http.post('/expense/create', {
          date: this.date,
          item: this.item,
          quantity: this.quantity,
          price: this.price,
          total: this.total,
          category: this.category,
          sheet: this.sheet
        }).success(function(data) {
          return $s.list();
        }).error(function(err) {
          return Toast(err.message);
        });
      }
    };
    $s.toggleSidenav = function(menuId) {
      console.log('here', menuId);
      return $mdSidenav(menuId).toggle();
    };
    $s.editComment = function(event, expense) {
      var editDialog, promise;
      event.stopPropagation();
      editDialog = {
        modelValue: expense.comment,
        placeholder: 'Add a comment',
        save: function(input) {
          if (input.$modelValue === 'Donald Trump') {
            input.$invalid = true;
            return $q.reject();
          }
          if (input.$modelValue === 'Bernie Sanders') {
            return expense.comment = 'FEEL THE BERN!';
          }
          expense.comment = input.$modelValue;
        },
        targetEvent: event,
        title: 'Add a comment',
        validators: {
          'md-maxlength': 30
        }
      };
      promise = void 0;
      if ($s.options.largeEditDialog) {
        promise = $mdEditDialog.large(editDialog);
      } else {
        promise = $mdEditDialog.small(editDialog);
      }
      promise.then(function(ctrl) {
        var input;
        console.log(ctrl, 'ctrl');
        input = ctrl.getInput();
        input.$viewChangeListeners.push(function() {
          input.$setValidity('test', input.$modelValue !== 'test');
        });
      });
    };
    $s.desserts = {
      'count': 9,
      'data': [
        {
          'name': 'Frozen yogurt',
          'type': 'Ice cream',
          'calories': {
            'value': 159.0
          },
          'fat': {
            'value': 6.0
          },
          'carbs': {
            'value': 24.0
          },
          'protein': {
            'value': 4.0
          },
          'sodium': {
            'value': 87.0
          },
          'calcium': {
            'value': 14.0
          },
          'iron': {
            'value': 1.0
          }
        }, {
          'name': 'Ice cream sandwich',
          'type': 'Ice cream',
          'calories': {
            'value': 237.0
          },
          'fat': {
            'value': 9.0
          },
          'carbs': {
            'value': 37.0
          },
          'protein': {
            'value': 4.3
          },
          'sodium': {
            'value': 129.0
          },
          'calcium': {
            'value': 8.0
          },
          'iron': {
            'value': 1.0
          }
        }, {
          'name': 'Eclair',
          'type': 'Pastry',
          'calories': {
            'value': 262.0
          },
          'fat': {
            'value': 16.0
          },
          'carbs': {
            'value': 24.0
          },
          'protein': {
            'value': 6.0
          },
          'sodium': {
            'value': 337.0
          },
          'calcium': {
            'value': 6.0
          },
          'iron': {
            'value': 7.0
          }
        }, {
          'name': 'Cupcake',
          'type': 'Pastry',
          'calories': {
            'value': 305.0
          },
          'fat': {
            'value': 3.7
          },
          'carbs': {
            'value': 67.0
          },
          'protein': {
            'value': 4.3
          },
          'sodium': {
            'value': 413.0
          },
          'calcium': {
            'value': 3.0
          },
          'iron': {
            'value': 8.0
          }
        }, {
          'name': 'Jelly bean',
          'type': 'Candy',
          'calories': {
            'value': 375.0
          },
          'fat': {
            'value': 0.0
          },
          'carbs': {
            'value': 94.0
          },
          'protein': {
            'value': 0.0
          },
          'sodium': {
            'value': 50.0
          },
          'calcium': {
            'value': 0.0
          },
          'iron': {
            'value': 0.0
          }
        }, {
          'name': 'Lollipop',
          'type': 'Candy',
          'calories': {
            'value': 392.0
          },
          'fat': {
            'value': 0.2
          },
          'carbs': {
            'value': 98.0
          },
          'protein': {
            'value': 0.0
          },
          'sodium': {
            'value': 38.0
          },
          'calcium': {
            'value': 0.0
          },
          'iron': {
            'value': 2.0
          }
        }, {
          'name': 'Honeycomb',
          'type': 'Other',
          'calories': {
            'value': 408.0
          },
          'fat': {
            'value': 3.2
          },
          'carbs': {
            'value': 87.0
          },
          'protein': {
            'value': 6.5
          },
          'sodium': {
            'value': 562.0
          },
          'calcium': {
            'value': 0.0
          },
          'iron': {
            'value': 45.0
          }
        }, {
          'name': 'Donut',
          'type': 'Pastry',
          'calories': {
            'value': 452.0
          },
          'fat': {
            'value': 25.0
          },
          'carbs': {
            'value': 51.0
          },
          'protein': {
            'value': 4.9
          },
          'sodium': {
            'value': 326.0
          },
          'calcium': {
            'value': 2.0
          },
          'iron': {
            'value': 22.0
          }
        }, {
          'name': 'KitKat',
          'type': 'Candy',
          'calories': {
            'value': 518.0
          },
          'fat': {
            'value': 26.0
          },
          'carbs': {
            'value': 65.0
          },
          'protein': {
            'value': 7.0
          },
          'sodium': {
            'value': 54.0
          },
          'calcium': {
            'value': 12.0
          },
          'iron': {
            'value': 6.0
          }
        }
      ]
    };
    console.log($s.desserts, 'desserts');
    $s.getTypes = function() {
      return ['Candy', 'Ice cream', 'Other', 'Pastry'];
    };
    $s.loadStuff = function() {
      $s.promise = $timeout((function() {}), 2000);
    };
    $s.logItem = function(item) {
      console.log(item.name, 'was selected');
    };
    $s.logOrder = function(order) {
      console.log('order: ', order);
    };
    return $s.logPagination = function(page, limit) {
      console.log('page: ', page);
      console.log('limit: ', limit);
    };
  }
]);

//# sourceMappingURL=ExpensesCtrl.js.map
