app.controller "ItemCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  "$mdEditDialog"
  "$mdDialog"
  ($s, $http, $mdSidenav, $mdEditDialog, $mdDialog)->
    console.log "Items"
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
      pageSelector: true
      rowSelection: false 
    list = ->
      $http.get('/item/list',{params: $s.query})
      .success (results) ->
        console.log results,'results'
        if results
          $s.items = results
    list()
    $touched = false
    reInit = ->
      $s.item = {}
      $s.itemForm.$setPristine()
      $s.itemForm.$setUntouched()
      #$s.itemForm.price.$touched = false

    $http.get('/unit/list')
    .success (result) ->
      console.log result,'unit'
      if result
        $s.units = result.data
          
    $s.item = {}
    $s.addItem = ->
      # defaultPrice = 
      #   amount: parseInt @price
      #   default: true
      console.log $s.item,'add'
      $http.post '/item/create', $s.item
      .success (data) -> 
        # index = $s.units.map((u)->u.id).indexOf(data.unit)
        # data.unit = $s.units[index]
        # $s.items.data.push data
        list()
        reInit()
      .error (err) ->
        reInit()
        Toast(err.message)

    $s.delete = (id)->
      console.log id, 'id'
      $http.delete('/item/delete/'+id)
      .success (result) ->
        console.log result,'deleted'
        # index = $s.items.data.map((i)->return i.id).indexOf(id)
        # $s.items.data.splice(index,1)
        list()

    # $s.addPrice = (event, item) ->
    #   event.stopPropagation()
    #   # in case autoselect is enabled
    #   promise = $mdEditDialog.show
    #     placeholder: 'Add a price'
    #     save: (input) ->
    #       console.log input,'input'
    #       item.price.push input.$modelValue
    #       return
    #     targetEvent: event
    #     title: 'Add a price'
    #     validators: 'md-maxlength': 5

    #   promise.then (ctrl) ->
    #     console.log ctrl,'ctrl'
    #     input = ctrl.getInput()
    #     # input.$viewChangeListeners.push ->
    #     #   input.$setValidity 'test', input.$modelValue != 'test'
    #     #   return
    #     return
    #   return

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

    # $s.showInput = (event, item) ->
    #   event.stopPropagation()
    #   # $s.itemArr = []
    #   console.log event,item,'evitem'
    #   $mdDialog.show
    #     controller: 'PriceCtrl'
    #     template: JST['user/item/price.html']()
    #     targetEvent: event
    #     locals: {item:item}
    #   .then (answer) ->
    #     console.log answer,'answer'
    #     # list()
    #     # $s.alert = 'You said the information was "' + answer + '".'
    #   # , ->
    #     # console.log answer,'answer2'
    #     # $s.alert = 'You cancelled the dialog.'

    # $s.editPrice = (event, item) ->
    #   event.stopPropagation()
    #   # $s.itemArr = []
    #   console.log event,item,'evitem'
    #   $mdDialog.show
    #     controller: 'PriceEditCtrl'
    #     template: JST['user/item/priceEdit.html']()
    #     targetEvent: event
    #     locals: {item:item}
    #   .then (answer) ->
    #     # console.log answer,'answer'
    #     # list()
    #     # $s.alert = 'You said the information was "' + answer + '".'
    #   # , ->
    #     # console.log answer,'answer2'
    #     # $s.alert = 'You cancelled the dialog.'

    $s.editItem = (event, item) ->
      console.log event,item,'evitem'
      $mdDialog.show
        controller: 'itemEditCtrl'
        template: JST['user/item/itemEdit.html']()
        targetEvent: event
        locals: {item:item, units:$s.units}
        clickOutsideToClose: true
      .then (answer) ->
        console.log answer,'answer'
        list()
        $s.alert = 'You said the information was "' + answer + '".'
      , ->
        console.log 'cancel'
        $s.alert = 'You cancelled the dialog.'

]
# .controller 'PriceEditCtrl', [
#   '$scope'
#   '$mdDialog'
#   '$http'
#   'item'
#   ($s, $mdDialog, $http, item) ->
#     console.log item,'item'
#     $s.prices = item.price
#     $s.closeDialog = ->
#       console.log 'close'
#       $mdDialog.cancel()

#     $s.save = ->
#       console.log $s.transaction, 'add'
#       $http
#         .post('/transaction/create', $s.transaction)
#         .success (data) ->
#           $mdDialog.hide(data)
#         .error (err) ->
#           $mdDialog.hide()
# ]
# .controller 'PriceCtrl', [
#   '$scope'
#   '$mdDialog'
#   '$http'
#   'item'
#   ($s, $mdDialog, $http, item) ->
#     $s.price = null
#     $s.closeDialog = ->
#       console.log 'close'
#       $mdDialog.cancel()

#     $s.addPrice = ->
#       item.price.push $s.price
#       console.log item.price, 'price'
#       $http
#         .put('/item/update', item)
#         .success (data) ->
#           console.log 'here'
#           $mdDialog.hide(data)
#         .error (err) ->
#           $mdDialog.hide()
# ]
.controller 'itemEditCtrl', [
  '$scope'
  '$mdDialog'
  '$http'
  'item'
  'units'
  ($s, $mdDialog, $http, item, units) ->
    $s.item = {}
    $s.item = item
    console.log $s.item,'item'
    $s.units = units
    $s.closeDialog = ->
      console.log 'close'
      $s.item = item
      console.log $s.item,'item'
      $mdDialog.cancel()

    $s.save = ->
      # item.price.push $s.price
      # console.log item.price, 'price'
      $s.item.unit = $s.item.unit.id
      console.log $s.item,'item'
      $http
        .put('/item/update', $s.item)
        .success (data) ->
          console.log data,'success'
          $mdDialog.hide(data)
        .error (err) ->
          $mdDialog.hide()

    # $s.deletePrice = (price)->
    #   console.log price, 'price'


]


# Roll Your Own

# $mdEditDialog.show(options);
# Parameter Type  Description
# options object  Dialog options.
# Property  Type  Default Description
# bindToController  bool  false If true, properties on the provided scope object will be bound to the controller
# clickOutsideToClose bool  true  The user can dismiss the dialog by clicking anywhere else on the page.
# controller  function string null  Either a constructor function or a string register with the $controller service. The controller will be automatically injected with $scope and $element. Remember to annotate your controller if you will be minifying your code.
# controllerAs  string  null  An alias to publish your controller on the scope.
# disableScroll bool  true  Prevent user scroll while the dialog is open.
# escToClose  bool  true  The user can dismiss the dialog by clicking the esc key.
# focusOnOpen bool  true  Will search the template for an md-autofocus element.
# locals  object  null  Optional dependancies to be injected into your controller. It is not necessary to inject registered services, the $injector will provide them for you.
# resolve object  null  Similar to locals but waits for promises to be resolved. Once the promises resolve, their return value will be injected into the controller and the dialog will open.
# scope object  null  Properties to bind to the new isolated scope.
# targetEvent event null  The event object. This must be provided and it must be from a table cell.
# template  string  null  The template for your dialog.
# templateUrl string  null  A URL to fetch your template from.
# The show method will return a promise that will resolve with the controller instance.

# Table cells have a md-placeholder CSS class that you can use for placeholder text.

# Example: A Table Cell That Opens An Edit Dialog

# <td md-cell ng-click="editComment($event, dessert)" ng-class="{'md-placeholder': !dessert.comment}">
#   {{dessert.comment || 'Add a comment'}}
# </td>