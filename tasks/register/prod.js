// module.exports = function (grunt) {
// 	grunt.registerTask('prod', [
// 		'compileAssets',
// 		'concat',
// 		'uglify',
// 		'cssmin',
// 		// 'sails-linker:prodJs',
// 		// 'sails-linker:prodStyles',
// 		// 'sails-linker:devTpl',
// 		// 'sails-linker:prodJsJade',
// 		// 'sails-linker:prodStylesJade',
// 		// 'sails-linker:devTplJade'
// 	]);
// };

module.exports = function (grunt) {
	var tasks = [
		'compileAssets',
		'concat',
		'uglify',
		'cssmin'
	];


	var users = require("../pipeline").users;

	for(var user in users){
		var names = {
			// prodJs:"prodJs_"+user,
			// prodStyles:"prodStyles_"+user,
			// devTpl:"devTpl_"+user,
			prodJsJade:"prodJsJade_"+user,
			prodStylesJade:"prodStylesJade_"+user,
			devTplJade:"devTplJade_"+user
		}
		for(var key in names){
			tasks.push("sails-linker:"+names[key]);
		}
	};

	grunt.registerTask('prod', tasks);
};
