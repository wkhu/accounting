module.exports = function (grunt) {
	grunt.registerTask('syncAssets', [
		'jst:dev',
		// 'less:dev',
		'sync:dev',
		'coffee:dev',
		'jade:dev',
		'sass:dev'
	]);
};
