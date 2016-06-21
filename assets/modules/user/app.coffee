app = angular.module("ExApp", ["ngRoute","ngAnimate","ngMaterial","ngMessages","md.data.table"])

app.config([ "$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
  .when("/",
    template: JST["user/dashboard/dashboard.html"]()
    controller: "DashboardCtrl"
  )
  .when("/sheets",
    template: JST["user/sheets/sheets.html"]()
    controller: "SheetsCtrl"
  )
  .when("/sheet/:id/expenses",
    template: JST["user/expenses/expenses.html"]()
    controller: "ExpensesCtrl"
  )
  .when("/profile",
    template: JST["common/profile/profile.html"]()
    controller: "ProfileCtrl"
  )
  .when("/settings",
    template: JST["common/settings/settings.html"]()
    controller: "SettingsCtrl"
  )
  .when("/item",
    template: JST["user/item/item.html"]()
    controller: "ItemCtrl"
  )
  .when("/unit",
    template: JST["user/unit/unit.html"]()
    controller: "UnitCtrl"
  )
  .when("/transaction",
    template: JST["user/transaction/transaction.html"]()
    controller: "TransactionCtrl"
  )
  .when("/inventory",
    template: JST["user/inventory/inventory.html"]()
    controller: "InventoryCtrl"
  )
  .otherwise redirectTo: '/'

])