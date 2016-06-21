app.controller "ExpensesCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  "$routeParams"
  "$q"
  "$timeout"
  "$mdEditDialog"
  ($s, $http, $mdSidenav, $rp, $q, $timeout, $mdEditDialog)->
    console.log "expenses", $rp

    # () ->
    #   deferred = $q.defer()
    #   $s.promise = deferred.promise
    #   # code
    #   deferred.resolve()

    # okToGreet = (n)->
    #   if n is 'Robin Hood' then true else false
    # asyncGreet = (name) ->
    #   # perform some asynchronous operation, resolve or reject the promise when appropriate.
    #   $q (resolve, reject) ->
    #     setTimeout (->
    #       if okToGreet(name)
    #         resolve 'Hello, ' + name + '!'
    #       else
    #         reject 'Greeting ' + name + ' is not allowed.'
    #       return
    #     ), 1000
    #     return
    # promise = asyncGreet('Robin Hoo')
    # promise.then ((greeting) ->
    #   alert 'Success: ' + greeting
    #   return
    # ), (reason) ->
    #   alert 'Failed: ' + reason
    #   return
    

    # asyncGreet = (name) ->
    #   deferred = $q.defer()
    #   setTimeout (->
    #     deferred.notify 'About to greet ' + name + '.'
    #     if okToGreet(name)
    #       deferred.resolve 'Hello, ' + name + '!'
    #     else
    #       deferred.reject 'Greeting ' + name + ' is not allowed.'
    #   ), 1000
    #   deferred.promise
    # promise = asyncGreet('Robin Hoo')
    # promise.then ((greeting) ->
    #   alert 'Success: ' + greeting
    # ), ((reason) ->
    #   alert 'Failed: ' + reason
    # ), (update) ->
    #   alert 'Got notification: ' + update

    $s.query = 
      order: 'date'
      limit: 50
      page: 1
      id: $rp.id

    $s.limits = [
      50
      100
      150
    ]

    $s.list = () ->
      $http.get('/expense/list',{params: $s.query})
      .success (result) ->
        console.log result,'list'
        if result
          $s.sum = 0
          $s.expenses = result
          $s.expenses.data.forEach (t) ->
            $s.sum+=t.total
        console.log $s.expenses, 'expenses'
    $s.list()
    
    $http.get('/sheet/show',{params: $rp})
    .success (result) ->
      console.log result,'sheet'
      if result
        $s.sheet = result

    $http.get('/category/list')
    .success (result) ->
      console.log result,'category'
      if result
        $s.categories = result.data

    $s.selected = []
    $s.options = 
      boundaryLinks: true
      largeEditDialog: false
      pageSelector: true
      rowSelection: true 

    $s.onReorder = (order) ->
      console.log order,'order'
      $s.query = angular.extend({}, $s.query, order: order)
      console.log $s.query
      $s.list() 

    $s.onPaginate = (page, limit) ->
      $s.query = angular.extend({}, $s.query, {page: page, limit: limit})
      console.log $s.query
      $s.list()

    $s.expense =
      date: null
      item: ''
      quantity: null
      price: null
      total: null
      category: ''
      sheet: $rp.id
      add: ->
        $s.expense.total = @quantity * @price
        console.log $s.expense,'add'
        $http
          .post('/expense/create', {
            date: @date
            item: @item
            quantity: @quantity
            price: @price
            total: @total
            category: @category
            sheet: @sheet
            })
          .success (data) ->
            $s.list()
          .error (err) ->
            Toast(err.message)

    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()

    $s.editComment = (event, expense) ->
      event.stopPropagation()
      # in case autoselect is enabled
      editDialog = 
        modelValue: expense.comment
        placeholder: 'Add a comment'
        save: (input) ->
          if input.$modelValue == 'Donald Trump'
            input.$invalid = true
            return $q.reject()
          if input.$modelValue == 'Bernie Sanders'
            return expense.comment = 'FEEL THE BERN!'
          expense.comment = input.$modelValue
          return
        targetEvent: event
        title: 'Add a comment'
        validators: 'md-maxlength': 30
      promise = undefined
      if $s.options.largeEditDialog
        promise = $mdEditDialog.large(editDialog)
      else
        promise = $mdEditDialog.small(editDialog)
      promise.then (ctrl) ->
        console.log ctrl,'ctrl'
        input = ctrl.getInput()
        input.$viewChangeListeners.push ->
          input.$setValidity 'test', input.$modelValue != 'test'
          return
        return
      return

    $s.desserts =
      'count': 9
      'data': [
        {
          'name': 'Frozen yogurt'
          'type': 'Ice cream'
          'calories': 'value': 159.0
          'fat': 'value': 6.0
          'carbs': 'value': 24.0
          'protein': 'value': 4.0
          'sodium': 'value': 87.0
          'calcium': 'value': 14.0
          'iron': 'value': 1.0
        }
        {
          'name': 'Ice cream sandwich'
          'type': 'Ice cream'
          'calories': 'value': 237.0
          'fat': 'value': 9.0
          'carbs': 'value': 37.0
          'protein': 'value': 4.3
          'sodium': 'value': 129.0
          'calcium': 'value': 8.0
          'iron': 'value': 1.0
        }
        {
          'name': 'Eclair'
          'type': 'Pastry'
          'calories': 'value': 262.0
          'fat': 'value': 16.0
          'carbs': 'value': 24.0
          'protein': 'value': 6.0
          'sodium': 'value': 337.0
          'calcium': 'value': 6.0
          'iron': 'value': 7.0
        }
        {
          'name': 'Cupcake'
          'type': 'Pastry'
          'calories': 'value': 305.0
          'fat': 'value': 3.7
          'carbs': 'value': 67.0
          'protein': 'value': 4.3
          'sodium': 'value': 413.0
          'calcium': 'value': 3.0
          'iron': 'value': 8.0
        }
        {
          'name': 'Jelly bean'
          'type': 'Candy'
          'calories': 'value': 375.0
          'fat': 'value': 0.0
          'carbs': 'value': 94.0
          'protein': 'value': 0.0
          'sodium': 'value': 50.0
          'calcium': 'value': 0.0
          'iron': 'value': 0.0
        }
        {
          'name': 'Lollipop'
          'type': 'Candy'
          'calories': 'value': 392.0
          'fat': 'value': 0.2
          'carbs': 'value': 98.0
          'protein': 'value': 0.0
          'sodium': 'value': 38.0
          'calcium': 'value': 0.0
          'iron': 'value': 2.0
        }
        {
          'name': 'Honeycomb'
          'type': 'Other'
          'calories': 'value': 408.0
          'fat': 'value': 3.2
          'carbs': 'value': 87.0
          'protein': 'value': 6.5
          'sodium': 'value': 562.0
          'calcium': 'value': 0.0
          'iron': 'value': 45.0
        }
        {
          'name': 'Donut'
          'type': 'Pastry'
          'calories': 'value': 452.0
          'fat': 'value': 25.0
          'carbs': 'value': 51.0
          'protein': 'value': 4.9
          'sodium': 'value': 326.0
          'calcium': 'value': 2.0
          'iron': 'value': 22.0
        }
        {
          'name': 'KitKat'
          'type': 'Candy'
          'calories': 'value': 518.0
          'fat': 'value': 26.0
          'carbs': 'value': 65.0
          'protein': 'value': 7.0
          'sodium': 'value': 54.0
          'calcium': 'value': 12.0
          'iron': 'value': 6.0
        }
      ]
    
    console.log $s.desserts,'desserts'
    $s.getTypes = ->
      [
        'Candy'
        'Ice cream'
        'Other'
        'Pastry'
      ]

    $s.loadStuff = ->
      $s.promise = $timeout((->
        # loading
        return
      ), 2000)
      return

    $s.logItem = (item) ->
      console.log item.name, 'was selected'
      return

    $s.logOrder = (order) ->
      console.log 'order: ', order
      return

    $s.logPagination = (page, limit) ->
      console.log 'page: ', page
      console.log 'limit: ', limit
      return
]

