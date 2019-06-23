var app;

app = angular.module("ExApp", ["ngRoute", "ngMaterial", "ngMessages", "ngAnimate"]);

app.config([
  "$routeProvider", "$locationProvider", "$mdThemingProvider", function($routeProvider, $locationProvider, $mdThemingProvider) {
    $mdThemingProvider.theme('docs-dark', 'default').primaryPalette('yellow').dark();
    $locationProvider.html5Mode(true);
    return $routeProvider.when("/login", {
      template: JST["public/login/login.html"](),
      controller: "LoginCtrl"
    }).when("/signup", {
      template: JST["public/signup/signup.html"](),
      controller: "SignupCtrl"
    }).otherwise({
      redirectTo: '/login'
    });
  }
]);

//# sourceMappingURL=app.js.map
