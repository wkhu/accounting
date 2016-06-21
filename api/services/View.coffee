roles = [
  "public"
  "user"
  "admin"
]

View =
  render: (req, res) ->
    # console.log req.headers.host, req.session.passport,'view'
    base     = req.headers.host
    userData = req.session.passport

    if userData and Object.keys(userData).length
      ###
      determine the active sessionType this user is using
      ###
      console.log roles[userData.user.userType], base:base
      res.view roles[userData.user.userType], base:base
    else
      console.log 'here'
      res.view roles[0], base:base

module.exports = View