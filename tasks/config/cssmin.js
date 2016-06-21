/**
 * Compress CSS files.
 *
 * ---------------------------------------------------------------
 *
 * Minifies css files and places them into .tmp/public/min directory.
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-cssmin
 */
module.exports = function(grunt) {
	var users = require("../pipeline").users,
    	linkConf = {};

    for(var key in users){
    	var css_key = "css_" + key;
        
    	linkConf[css_key] = {
    		src: [".tmp/public/concat/" + key + ".css"],
    		dest:".tmp/public/min/" + key + ".min.css"
    	};
    	
    };

	grunt.config.set('cssmin',linkConf);

	grunt.loadNpmTasks('grunt-contrib-cssmin');
};
