module.exports = function (grunt) {
	var tasks = [],users = require("../pipeline").users;

	for(var user in users){
		var names = {
			// devJs:"devJs_"+user,
			// devStyles:"devStyles_"+user,
			// devTpl:"devTpl_"+user,
			devJsJade:"devJsJade_"+user,
			devStylesJade:"devStylesJade_"+user,
			devTplJade:"devTplJade_"+user
		}
		
		for(var key in names){
			tasks.push("sails-linker:"+names[key]);
		}
	}
	console.log(tasks, users);
	grunt.registerTask('linkAssets',tasks);

};
