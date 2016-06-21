module.exports = function (grunt) {
	grunt.registerTask('compileAssets', [
		'clean:dev',
		'jade:dev',
		'jst:dev',
		// 'less:dev',
		'copy:dev',
		'coffee:dev',
		'sass:dev',
		'shell:dev'
	]);
};
