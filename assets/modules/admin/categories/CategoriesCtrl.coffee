app.controller "CategoriesCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  ($s, $http, $mdSidenav)->
    console.log "categories"
    $s.query = 
      order: '',
      limit: 10,
      page: 1
    $s.limits = [
      10
      20
      30  
    ]
    $s.selected = []
    $s.options = 
      boundaryLinks: true
      largeEditDialog: false
      pageSelector: true
      rowSelection: true 
    $s.list = () ->
      $http.get('/category/list',{params: $s.query})
      .success (data) ->
        console.log data,'data'
        if data
          $s.categories = data
    $s.list()
    $s.category =
        name: ''
        description: ''
        add: ->
          console.log $s.category,'add'
          $http
            .post('/category/create', 
              {
                name: @name
                description: @description
              })
            .success (data) ->
              $s.list()
            .error (err) ->
              Toast(err.message)

    $s.onReorder = (order) ->
      console.log order,'order'
      $s.query = angular.extend({}, $s.query, order: order)
      console.log $s.query
      $s.list() 

    $s.onPaginate = (page, limit) ->
      $s.query = angular.extend({}, $s.query, {page: page, limit: limit})
      console.log $s.query
      $s.list()

    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()
]

# name: "string"
#     description: "string"
#     expenses:
#       collection: "expense"
#       via: "category"