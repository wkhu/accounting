/**
 * Minify files with UglifyJS.
 *
 * ---------------------------------------------------------------
 *
 * Minifies client-side javascript `assets`.
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-uglify
 *
 */
module.exports = function(grunt) {
	var users = require("../pipeline").users,
        linkConf = {
            options:{
                mangle:false
            }
        };

    for(var key in users){
        var js_key = "js_"+key;

        linkConf[js_key] = {
            src: [".tmp/public/concat/"+key+".js"],
            dest:".tmp/public/min/"+key+".min.js",

        };
        
    };
    
	grunt.config.set('uglify',linkConf);

	grunt.loadNpmTasks('grunt-contrib-uglify');
};
