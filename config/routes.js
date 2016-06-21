var skip = [
  '/',
  '/:link',
  '/sheet/:id/expenses'
];

var routes = {
  '/': {
    controller: 'SiteController',
    action: 'index'
  },
  'GET /signup': {
    controller: 'SiteController',
    action: 'index'
  },
  'POST /signup': {
    controller: 'SiteController',
    action: 'signup'
  },
  'GET /login': {
    controller: 'SiteController',
    action: 'index'
  },
  'POST /login': {
    controller: 'SiteController',
    action: 'login'
  },
  'GET /logout': {
    controller: 'SiteController',
    action: 'logout'
  },
  '/test': {
    controller: 'SiteController',
    action: 'test'
  }
};

skip.forEach(function (url) {
  routes[url] = {
    controller  : 'SiteController',
    action      : 'index',
    skipAssets  : true
  }
});

module.exports.routes = routes;

