/**
 * Concatenate files.
 *
 * ---------------------------------------------------------------
 *
 * Concatenates files javascript and css from a defined array. Creates concatenated files in
 * .tmp/public/contact directory
 * [concat](https://github.com/gruntjs/grunt-contrib-concat)
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-concat
 */
module.exports = function(grunt) {
	var users = require("../pipeline").users,
        linkConf = {};

    for(var key in users){
        var js_key = "js_" + key,
            css_key = "css_" + key;
        obj = users[key]
        linkConf[js_key] = {
            src: obj.js,
            dest:".tmp/public/concat/" + key + ".js"
        };

        linkConf[css_key] = {
            src: obj.css,
            dest:".tmp/public/concat/" + key + ".css"
        };
        
    }
    
	grunt.config.set('concat',linkConf);

	grunt.loadNpmTasks('grunt-contrib-concat');
};
