passport = require 'passport'

module.exports =
  index: (req, res) ->
    console.log 'index'
    View.render req, res

  test: (req, res) ->
    bcrypt = require 'bcrypt'
    # User.find().exec (err, data) ->
    #   res.json data

    User.findOne { email: 'test@test' }, (err, user) ->
      pass = 'test'
      console.log user,err, pass
      if !user 
        console.log null, false, { message: 'Incorrect email.' }
      if user 
        bcrypt.compare pass, user.password, (err, result)->
          if err 
            console.log null, false, { message: 'Server error.' }
          else if !result
            console.log null, false, { message: 'Incorrect password.' }
          else if result
            console.log null, user, {message:'Logged in successfully'}

  login: (req, res) ->
    console.log req.body,'body'
    passport.authenticate('local',
    failureRedirect: '/login', 
    (err, user, info) ->
      console.log err, user, info,'info'
      if err
        console.log err,'sa err'
        return res.negotiate(err) 
      # return res.error(401, err, res)
      if !user
        console.log 'nisulod sa !user'
        return res.json(info)
        # return res.redirect('/login') 
      req.logIn(user, (err) ->
        return res.negotiate(err) if err
        console.log user,'user'
        User.update(user.id, lastLoggedIn: new Date())
        .exec (err, updated) ->
          if err
            return res.negotiate(err)
          console.log updated,'Updated user last logged in ' + updated[0].lastLoggedIn
          return res.redirect('/')
      )
    )(req, res)

  signup: (req, res, next) ->
    data = req.body
    User.create data
    .exec (err,user) ->
      if user
        req.login(user, (err) ->
          return next(err) if err
          return res.ok()
          # return res.redirect('/')
        )
      else
        return res.negotiate(err) if err

  logout: (req, res) ->
    console.log 'logout naman unta'
    req.logout()
    # req.session.destroy()
    res.redirect '/login'

