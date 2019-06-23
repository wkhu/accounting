app.controller "UsersCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  ($s, $http, $mdSidenav)->
    console.log "users"
    $s.query = 
      order: '',
      limit: 5,
      page: 1
    $s.limits = [
      5
      10
      15  
    ]
    $s.selected = []
    $s.options = 
      boundaryLinks: true
      largeEditDialog: false
      pageSelector: true
      rowSelection: false 
    list = () ->
      $http.get('/user/list')
      .success (data) ->
        console.log data,'user data'
        if data
          $s.users = data
          console.log $s.users, 'scope userss'
    list()

    $s.delete = (id)->
      $http.delete('/user/delete/'+id)
      .success (result) ->
        list()

    $s.onReorder = (order) ->
      console.log order,'order'
      $s.query = angular.extend({}, $s.query, order: order)
      console.log $s.query
      list()

    $s.onPaginate = (page, limit) ->
      $s.query = angular.extend({}, $s.query, {page: page, limit: limit})
      console.log $s.query
      list()

    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()
]