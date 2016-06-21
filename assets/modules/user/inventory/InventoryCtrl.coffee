app.controller "ItemCtrl",[
  "$scope"
  "$http"
  "$mdSidenav"
  "$mdEditDialog"
  "$mdDialog"
  ($s, $http, $mdSidenav, $mdEditDialog, $mdDialog)->
    console.log "Inventory"
]