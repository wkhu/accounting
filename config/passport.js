var passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy
  , bcrypt = require('bcrypt');

passport.serializeUser(function(user, done) {
  id = user.id ? user.id : user._id
  session = {
    id: id,
    userType: user.userType
  }
  done(null, session);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function(err, user) {
    done(err, user);
  });
});

module.exports.http = {
  customMiddleware: function(app){
    passport.use(new LocalStrategy(
      function(username, password, done) {
        console.log(username,password,'epass');
        User.native(function(err, collection) {
          collection.find({$or:[{username: username},{email: username}]}).toArray(function (err, user) {
            console.log(err, user, user.length, 'passport find');
            if (err) { 
              return done(err); 
            }else if (user){
              if (user.length > 0){
                bcrypt.compare(password, user[0].password, function(err, result){
                  if (err) {
                    console.log(err,'err');
                    return done(null, false, { message: 'Server error.' });
                  } else if (!result){
                    console.log('incorrect pass');
                    // return done({ message: 'Invalid email or password.' }, null)
                    return done(null, false, { message: 'Invalid email or password.' });
                  } else {
                    console.log(user,'success');
                    return done(null, user[0], {message:'Logged in successfully'});
                  }
                }); 
              }else{
                console.log('incorrect email')
                // return done({ message: 'Invalid email or password.' }, null)
                return done(null, false, { message: 'Invalid email or password.' });
              }
            }
          });
        });
      }
    ));

    app.use(passport.initialize());
    app.use(passport.session());
  }
};
