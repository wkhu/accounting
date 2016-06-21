# angular
#   .module('ExApp')
app.factory "TOAST", [
    "$mdToast"
    (toast) ->
      return (message, position) ->
        pos = if position? then position else 'top right'
        toast.show(
          toast.simple()
            .content message
            .position pos
        )
  ]
