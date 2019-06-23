this["JST"] = this["JST"] || {};

this["JST"]["public/login/login.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div layout="column" layout-align="center center" ng-cloak="ng-cloak"><header layout="column" layout-align="center center"><h1>Accounting System</h1><h3>By Windyl Khu</h3></header><md-content layout-padding="layout-padding" class="md-whiteframe-z1"><form ng-submit="login()"><div layout="column"><md-input-container class="md-block"><label>Username or email address</label><input ng-model="user.username"/></md-input-container><md-input-container class="md-block"><label>Password</label><input type="password" ng-model="user.password"/></md-input-container><md-button type="submit" class="md-raised md-primary">Log In</md-button></div></form></md-content><p> \nDont have an account? <a href="/signup">Signup</a></p><footer layout="column" layout-align="center center"><a href="http://www.polymer-project.org/" target="_blank"><img src="https://www.polymer-project.org/images/logos/p-logo.svg"/></a><p>You Gotta Love <a href="http://www.polymer-project.org/" target="_blank">Google</a></p></footer></div>';

}
return __p
};

this["JST"]["public/signup/signup.html"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div layout="column" layout-align="center center" ng-cloak="ng-cloak"><header><h1>Create an Account</h1></header><md-content layout-padding="layout-padding" class="md-whiteframe-z1"><form name="signupForm" ng-submit="signup()"><div layout="column"><div layout="row"><md-input-container class="md-icon-float md-block"><label>First name</label><md-icon md-font-icon="icon-vcard"></md-icon><input ng-model="user.firstName" name="firstName" required="required"/><div ng-messages="signupForm.firstName.$error"><div ng-message="required">First name is required.</div></div></md-input-container><md-input-container class="md-block"><label>Last name</label><input ng-model="user.lastName" name="lastName" required="required"/><div ng-messages="signupForm.lastName.$error"><div ng-message="required">Last name is required.</div></div></md-input-container></div><md-input-container class="md-icon-float md-block"><label>Username</label><md-icon md-font-icon="icon-user"></md-icon><input ng-model="user.username" name="username" required="required"/><div ng-messages="signupForm.username.$error"><div ng-message="required">Username is required.</div></div></md-input-container><md-input-container class="md-icon-float md-block"><label>Email</label><md-icon md-font-icon="icon-mail"></md-icon><input ng-model="user.email" name="email" ng-pattern="pattern" required="required"/><div ng-messages="signupForm.email.$error"><div ng-message-exp="[\'required\', \'pattern\']">Email is required and must look like an e-mail address.</div></div></md-input-container><div layout="row"><md-input-container class="md-icon-float md-block"><label>Password</label><md-icon md-font-icon="icon-lock"></md-icon><input type="password" name="password" ng-model="user.password" required="required"/><div ng-messages="signupForm.password.$error"><div ng-message="required">Password is required.</div></div></md-input-container><md-input-container class="md-block"><label>Confirm Password</label><input type="password" name="confirmPassword" ng-model="user.confirmPassword" required="required" compared-to="user.password"/><div ng-messages="signupForm.confirmPassword.$error"><div ng-message="required">Confirmation password is required.</div><div ng-message="unique">Password must match.</div></div></md-input-container></div><md-button type="submit" ng-disabled="signupForm.$invalid" class="md-raised md-primary">Sign Up</md-button></div></form></md-content><p>Go back to <a href="/login">Login</a></p></div>';

}
return __p
};