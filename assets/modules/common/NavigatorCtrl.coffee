app.controller "NavigatorCtrl",[
  "$scope"
  "$location"
  "$timeout"
  "$http"
  "$routeParams"
  "$mdSidenav"
  ($s, $l, $t, $http, $rp, $mdSidenav)->
    console.log 'navis'
    # $s.toggleSidenav = (menuId) ->
    #   console.log 'here', menuId
    #   $mdSidenav(menuId).toggle()

    $http.get('/user/show/self')
    .success (data) ->
      $s.user = data
  
    $s.active = (url)->
      path = $l.path() || document.location.pathname
      if url isnt "/"
        i = path.indexOf url
        return i > -1
      else
        return path is url

    # $s.menus = []

    # $http.get "/navigation/user"
    # .success (data)->
    #   $s.menus = data.menus if data
    #   $s.select +$rp.submenuId


    # $s.select = (submenuId)->
    #   $s.menus.forEach (m)->
    #     m.active = false
    #     m.submenus.forEach (s)->
    #       if s.id is submenuId
    #         s.active = true
    #         m.active = true
    #       else
    #         s.active = false
    #       return
    #   return
    # $s.$on "$routeChangeSuccess", ->
    #   $s.select +$rp.submenuId
    #   return
    # return

    # $s.menu = [
    #   {
    #     title: 'Dashboard'
    #     icon: 'icon-bar-chart'
    #   }
    #   {
    #     title: 'Sheets'
    #     icon: 'icon-database'
    #   }
    # ]
    # $s.admin = [
    #   {
    #     title: 'User'
    #     icon: 'icon-user'
    #   }
    #   {
    #     title: 'Logout'
    #     icon: 'icon-power-off'
    #   }
    # ]

    $s.navigateTo = (to, event) ->
      console.log to, event
      switch to
        when 'Dashboard'
          $l.path '/dashboard'
        when 'Sheets'
          $l.path '/sheets'
        when 'Users'
          $l.path '/users'
        when 'Categories'
          $l.path '/categories'
        when 'Profile'
          $l.path '/profile'
        when 'Settings'
          $l.path '/settings'
        when 'Item'
          $l.path '/item'
        when 'Unit'
          $l.path '/unit'
        when 'Transaction'
          $l.path '/transaction'
        when 'Inventory'
          $l.path '/inventory'
        when 'Logout'
          document.location = '/logout'
]

###

 $scope.$on('$routeChangeSuccess', function () {
            var items = $scope.items;
            var path = $location.path();

            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                var href = item['href'];
                item['current'] = !!href && href.substring(1) === path;
            }
        });
###