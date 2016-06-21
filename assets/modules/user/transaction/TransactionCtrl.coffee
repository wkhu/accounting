app.controller "TransactionCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  "$q"
  "$timeout"
  "$mdEditDialog"
  "$mdDialog"
  ($s, $http, $mdSidenav, $q, $timeout, $mdEditDialog, $mdDialog)->
    console.log "transactions"
    $s.query = 
      order: 'date'
      limit: 10
      page: 1

    $s.limits = [
      10
      20
      30
    ]
    reInit = ->
      $s.transaction = {}
      $s.transactionForm.$setPristine()
      $s.transactionForm.$setUntouched()

    # USER (user) ->
    #   console.log user,'user'
    #   $s.query.id = user.id
    #   console.log $s.query,'query'

    list = ->
      console.log $s.query,'params'
      $http.get('/transaction/list',{params: $s.query})
      .success (result) ->
        console.log result,'list'
        if result
          # $s.sum = 0
          $s.transactions = result
          # $s.transactions.data.forEach (t) ->
          #   $s.sum+=t.total
        console.log $s.transactions, 'transactions'
    list()


    $s.add = ->
      #get previous stock data
      # $http.get('/transaction/showLatest',{params:item:@item})
      # .success (result) ->
      #   console.log result,'stock data'
      #   console.log 'item',$s.transaction.quantity, $s.transaction.value 
      #   if result
      #     console.log 'sa naa daan', result.stockBalance, result.stockValue
      #     if $s.transaction.type is true
      #       $s.transaction.stockBalance = $s.transaction.quantity + result.stockBalance
      #       $s.transaction.stockValue = $s.transaction.value + result.stockValue
      #     else
      #       $s.transaction.stockBalance = result.stockBalance - $s.transaction.quantity
      #       $s.transaction.stockValue = result.stockValue - $s.transaction.value
      #   else
      #     console.log 'sa wala'
      #     if $s.transaction.type is true
      #       $s.transaction.stockBalance += $s.transaction.quantity
      #       $s.transaction.stockValue += $s.transaction.value 
      #     else
      #       $s.transaction.stockBalance -= $s.transaction.quantity
      #       $s.transaction.stockValue -= $s.transaction.value
      console.log $s.transaction,'add'
      $http
        .post '/transaction/create', $s.transaction
        .success (data) ->
          reInit()
          list()
        .error (err) ->
          reInit()
          Toast(err.message)

    $s.editTransaction = (event, transaction) ->
      console.log event,transaction,'evitem'
      $mdDialog.show
        controller: 'transactionEditCtrl'
        template: JST['user/transaction/transactionEdit.html']()
        targetEvent: event
        locals: {transaction:transaction, units:$s.units, items:$s.items}
        clickOutsideToClose: true
      .then (answer) ->
        console.log answer,'answer'
        list()

    $s.selected = []
    $s.options = 
      boundaryLinks: true
      largeEditDialog: false
      pageSelector: true
      rowSelection: true 

    

    $http.get('/item/list')
    .success (result) ->
      console.log result,'item'
      if result
        $s.items = result.data

    $http.get('/unit/list')
    .success (result) ->
      console.log result,'unit'
      if result
        $s.units = result.data

    $s.onReorder = (order) ->
      console.log order,'order'
      $s.query = angular.extend({}, $s.query, order: order)
      console.log $s.query,'onreorder'
      $s.list() 

    $s.onPaginate = (page, limit) ->
      console.log page,limit,'pagelim'
      $s.query = angular.extend({}, $s.query, {page: page, limit: limit})
      console.log $s.query,'onpaginate'
      $s.list()

    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()

    $s.loadStuff = ->
      $s.promise = $timeout((->
        # loading
        return
      ), 2000)
      return

    $s.logItem = (item) ->
      console.log item.name, 'was selected'
      return

    $s.$watch 'transaction.item', (updated) ->
      # console.log updated,'updated'
      if updated
        $http.get '/item/show/' + updated
        .success (result) ->
          console.log result,'unitWatch'
          if result
            $s.transaction.price = result.price
            $s.transaction.unit = result.unit.unitName
            console.log $s.transaction,'transaction up'
    ,true


      # $s.showInput = (ev) ->
      #   $s.transaction =
      #     date: null
      #     item: 'test'
      #     unit: ''
      #     price: null
      #     type: null
      #     quantity: null
      #     value: null
      #     stockBalance: null
      #     stockValue: null
      #     user: $s.user.id
      #   $http.get('/item/list')
      #   .success (result) ->
      #     console.log result,'unit'
      #     if result
      #       $s.items = result.data

      #   $http.get('/unit/list')
      #   .success (result) ->
      #     console.log result,'unit'
      #     if result
      #       $s.units = result.data
      #   $mdDialog.show
      #     controller: 'DialogCtrl'
      #     template: JST['user/transaction/input.html']()
      #     targetEvent: ev
      #   .then (answer) ->
      #     console.log answer,'answer'
      #     $s.list()
      #     $s.alert = 'You said the information was "' + answer + '".'
      #   , ->
      #     console.log answer,'answer2'
      #     $s.alert = 'You cancelled the dialog.'
]
.controller 'transactionEditCtrl', [
  '$scope'
  '$mdDialog'
  '$http'
  'transaction'
  'units'
  'items'
  ($s, $mdDialog, $http, transaction, units, items) ->
    $s.transaction = transaction
    console.log $s.transaction,'trans'
    $s.transaction.date = new Date($s.transaction.date)
    $s.units = units
    $s.items = items
    $s.$watch 'transaction.item.id', (updated) ->
      console.log updated,'updated'
      if updated
        $http.get '/item/show/' + updated
        .success (result) ->
          console.log result,'unitWatch'
          if result
            $s.transaction.price = result.price
            $s.unit = result.unit.unitName
            console.log $s.transaction,'transaction up'
    ,true
    # index = $s.units.map((u)-> u.id).indexOf($s.transaction.item.unit)
    # $s.unit = $s.units[index].unitName
    $s.closeDialog = ->
      console.log 'close'
      $mdDialog.cancel()

    $s.save = ->
      # item.price.push $s.price
      # console.log item.price, 'price'

      console.log $s.transaction,'transaction'
      # $http
      #   .put('/transaction/update', $s.transaction)
      #   .success (data) ->
      #     console.log data,'success'
      #     $mdDialog.hide(data)
      #   .error (err) ->
      #     $mdDialog.hide()

    # $s.deletePrice = (price)->
    #   console.log price, 'price'


]