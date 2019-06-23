app.controller "UnitCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  "TOAST"
  "$mdEditDialog"
  ($s, $http, $mdSidenav, Toast, $mdEditDialog)->
    console.log "units"
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
      rowSelection: false 
    unitNames = []
    list = ->
      $http.get('/unit/list',{params: $s.query})
      .success (results) ->
        console.log results,'results'
        if results
          $s.units = results
          units = $s.units.data
          unitNames = units.map (unit) ->
            {
              value: unit.unitName.toLowerCase()
              display: unit.unitName
            }
          console.log unitNames,units,$s.units,'unitcheck'
    list()

    reInit = ->
      $s.unit = {}
      $s.unitForm.$setPristine()
      $s.unitForm.$setUntouched()

    querySearch = (query) ->
      console.log query, 'querySearch'
      console.log unitNames,'unitNames'
      results = if query then unitNames.filter(createFilterFor(query)) else []
      console.log results,'querysearch results'
      results

    createFilterFor = (query) ->
      console.log query, 'createfilterfor'
      lowercaseQuery = angular.lowercase(query)
      console.log lowercaseQuery,'lowercase'
      (unit) ->
        console.log unit,'createfilterfor unit'
        unit.value.indexOf(lowercaseQuery) == 0

    $s.searchText = null
    $s.selectedItem = null
    $s.querySearch = querySearch

    $s.unit = {}
    $s.addUnit = ->
      # $s.unit.unitName = if $s.selectedItem is null then $s.searchText else $s.selectedItem.value
      console.log $s.unit,'add'

      $http
        .post '/unit/create', $s.unit
        .success (data) ->
          console.log data, 'data'
          list()
          # $s.units.data.push data
          reInit()
        .error (err) ->
          console.log err,'err'
          reInit()
          if err.invalidAttributes.unitName[0].rule is "unique"
            message = "A record with that Unit Name already exists: " + '"' + err.invalidAttributes.unitName[0].value + '"'
            Toast message

    $s.editUnit = (event, unit) ->
      event.stopPropagation()
      # in case autoselect is enabled
      editDialog = 
        modelValue: unit.unitName
        save: (input) ->
          unit.unitName = input.$modelValue
          $http.put '/unit/update', unit
          .success (err, data)->
            console.log err, data, 'errdata'

        targetEvent: event
      promise = $mdEditDialog.small(editDialog)
      promise.then (ctrl) ->
        input = ctrl.getInput()

    $s.delete = (id)->
      $http.delete('/unit/delete/'+id)
      .success (result) ->
        # index = $s.units.data.map((i)-> return i.id).indexOf id
        # $s.units.data.splice(index,1)
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
