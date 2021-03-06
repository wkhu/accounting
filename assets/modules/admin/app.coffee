app = angular.module("ExApp", ["ngRoute","ngAnimate","ngMaterial","md.data.table"])

app.config([ "$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $routeProvider
  .when("/users",
    template: JST["admin/users/users.html"]()
    controller: "UsersCtrl"
  )
  .when("/categories",
    template: JST["admin/categories/categories.html"]()
    controller: "CategoriesCtrl"
  )
  .when("/user",
    template: JST["common/settings/settings.html"]()
    controller: "SettingsCtrl"
  )
  .otherwise redirectTo: '/users'

])