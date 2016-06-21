isEmpty = (obj) ->
  for key of obj
    if obj.hasOwnProperty(key)
      return false
  true

module.exports = isEmpty

