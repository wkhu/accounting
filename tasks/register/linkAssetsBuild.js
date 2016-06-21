// module.exports = function (grunt) {
// 	grunt.registerTask('linkAssetsBuild', [
// 		// 'sails-linker:devJsRelative',
// 		// 'sails-linker:devStylesRelative',
// 		// 'sails-linker:devTpl',
// 		'sails-linker:devJsRelativeJade',
// 		'sails-linker:devStylesRelativeJade',
// 		'sails-linker:devTplJade'
// 	]);
// };

module.exports = function (grunt) {
	var tasks = [],users = require("../pipeline").users;

	for(var user in users){
		var names = {
			// devJsRelative:"devJsRelative_"+user,
			// devStylesRelative:"devStylesRelative_"+user,
			// devTpl:"devTpl_"+user,
			devJsRelativeJade:"devJsRelativeJade_"+user,
			devStylesRelativeJade:"devStylesRelativeJade_"+user,
			devTplJade:"devTplJade_"+user
		}
		
		for(var key in names){
			tasks.push("sails-linker:"+names[key]);
		}
	}

	grunt.registerTask('linkAssetsBuild',tasks);

};
