app.controller "DashboardCtrl",[
  "$scope"
  "$mdSidenav"
  "$http"
  "USER"
  ($s, $mdSidenav, $http, USER)->
    console.log "dashboard"
    $s.query = {}
    $s.chosenItem = null
    groupBy = (array, f)->
      groups = {}
      console.log array,'array'
      array.forEach (item)->     
        group = JSON.stringify(f(item))
        console.log group,'stringified'
        groups[group] = groups[group] or []
        console.log groups[group],'groups[group]'
        groups[group].push(item)
      console.log groups, 'objectkeys'
      return Object.keys(groups).map (group)->
        console.log groups[group],group,'group'
        return groups[group]

    computeStock = (array) ->
      array.forEach (group) ->
        stockBalance = 0
        stockValue = 0
        group.forEach (item) ->
          tempBal = item.quantity
          tempVal = tempBal * item.price
          if item.type
            stockBalance += tempBal
            stockValue += tempVal
          else
            stockBalance -= tempBal
            stockValue -= tempVal
          item.stockBalance = stockBalance
          item.stockValue = stockValue
      return array 

    USER (user) ->
      console.log user,'user'
      $s.query.user = user.id
      $s.list = () ->
        console.log $s.query,'query'
        $http.get('/transaction/list',{params: $s.query})
        .success (results) ->
          console.log results,'results'
          if results
            $s.stocks = computeStock(groupBy(results.data, (item)->
              console.log item,'item'
              return [item.item]))
            # $s.stocks = computeStock($s.stocks)
            console.log $s.stocks, 'after compute'
      $s.list()

    $http.get('/item/list')
    .success (result) ->
      console.log result,'item'
      if result
        $s.items = result.data

    $s.toggleSidenav = (menuId) ->
      console.log 'here', menuId
      $mdSidenav(menuId).toggle()

    $s.$watch 'chosenItem', (updated) ->
      console.log updated,'updated'
      if updated
        $s.query.id = updated
        $s.show = () ->
          console.log $s.query,'query'
          $http.get('/transaction/show',{params: $s.query})
          .success (results) ->
            console.log results,'results'
            if results
              $s.stocks = computeStock(groupBy(results, (item)->
                console.log item,'item'
                return [item.item]))
              # $s.stocks = computeStock($s.stocks)
              console.log $s.stocks, 'after compute'
        $s.show()
    ,true

]