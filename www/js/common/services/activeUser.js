app.factory('USER', [
  "$http", function($http) {
    return function(callback) {
      return $http.get('/user/show/self').success(function(user) {
        console.log('active user: ' + user);
        return callback(user);
      });
    };
  }
]);

//# sourceMappingURL=activeUser.js.map
