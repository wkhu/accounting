/**
 * Autoinsert script tags (or other filebased tags) in an html file.
 *
 * ---------------------------------------------------------------
 *
 * Automatically inject <script> tags for javascript files and <link> tags
 * for css files.  Also automatically links an output file containing precompiled
 * templates using a <script> tag.
 *
 * For usage docs see:
 * 		https://github.com/Zolmeister/grunt-sails-linker
 *
 */
module.exports = function(grunt) {

	var users = require('../pipeline').users,
		linkerConf = {};
	
	// *For increased security
	// function randomString(length) {
	// 	var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
	// 		result = '';

	// 	for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
	// 	return result;
	// }

	// var getRandom = function(){
	// 	return "?v="+randomString(7);
	// }

	for(var user in users){
		var names = {
			// devJs:"devJs_"+user,
			// devJsRelative:"devJsRelative_"+user,
			// prodJs:"prodJs_"+user,
			// prodJsRelative:"prodJsRelative_"+user,
			// devStyles:"devStyles_"+user,
			// devStylesRelative:"devStylesRelative_"+user,
			// prodStyles:"prodStyles_"+user,
			// prodStylesRelative:"prodStylesRelative_"+user,
			// devTpl:"devTpl_"+user,
			devJsJade:"devJsJade_"+user,
			devJsRelativeJade:"devJsRelativeJade_"+user,
			prodJsJade:"prodJsJade_"+user,
			prodJsRelativeJade:"prodJsRelativeJade_"+user,
			devStylesJade:"devStylesJade_"+user,
			devStylesRelativeJade:"devStylesRelativeJade_"+user,
			prodStylesJade:"prodStylesJade_"+user,
			prodStylesRelativeJade:"prodStylesRelativeJade_"+user,
			devTplJade:"devTplJade_"+user
		}
		var U = users[user];

		// for(var key in names){
		// 	var options = {
		// 		script:{
		// 			startTag: '// SCRIPTS',
		// 			endTag: '// SCRIPTS END',
		// 			fileTmpl: 'script(src="%s'+getRandom()+'")',
		// 			appRoot: '.tmp/public',
		// 			relative: true
		// 		},
		// 		style:{
		// 			startTag: '// STYLES',
		// 			endTag: '// STYLES END',
		// 			fileTmpl: 'link(rel="stylesheet", href="%s'+getRandom()+'")',
		// 			appRoot: '.tmp/public',
		// 			relative: true

		// 		},
		// 		template:{
		// 			startTag: '// TEMPLATES',
		// 			endTag: '// TEMPLATES END',
		// 			fileTmpl: 'script(type="text/javascript", src="%s'+getRandom()+'")',
		// 			appRoot: '.tmp/public',
		// 			relative: true
		// 		}			
		// 	}

		for(var key in names){
			var options = {
				script:{
					startTag: '// SCRIPTS',
					endTag: '// SCRIPTS END',
					fileTmpl: 'script(src="%s")',
					appRoot: '.tmp/public',
					relative: true
				},
				style:{
					startTag: '// STYLES',
					endTag: '// STYLES END',
					fileTmpl: 'link(rel="stylesheet", href="%s")',
					appRoot: '.tmp/public',
					relative: true

				},
				template:{
					startTag: '// TEMPLATES',
					endTag: '// TEMPLATES END',
					fileTmpl: 'script(type="text/javascript", src="%s")',
					appRoot: '.tmp/public',
					relative: true
				}			
			}
			/*
				
			*/
			var prop = names[key],
				isRelative = prop.indexOf("Relative") > -1,
				keyConfig = {
					options:{},
					files:{}
				},
				files_dir = "views/"+user+".jade",
				link_dir = [];

			if(prop.indexOf("Js") !== -1 ){
				if(!isRelative)
					delete options.script.relative;

				keyConfig.options = options.script
				
				if(prop.indexOf("dev") !== -1){
					link_dir = U.js;
				}else{
					link_dir = [];
					link_dir.push(".tmp/public/min/"+user+".min.js");
				}

			}else if(prop.indexOf("Styles") !== -1 ){
				if(!isRelative)
					delete options.style.relative;
				
				keyConfig.options = options.style;

				if(prop.indexOf("dev") !== -1){
					link_dir = U.css;
				}else{
					link_dir = [];
					link_dir.push(".tmp/public/min/"+user+".min.css");
				}
			}else{
				keyConfig.options = options.template;
				link_dir = [];
				link_dir.push(".tmp/public/templates/jst_"+user+".js");
			}


			keyConfig.files[files_dir] = link_dir;

			linkerConf[prop] = keyConfig;
		}
		
	}
	
	grunt.config.set('sails-linker', linkerConf);

	grunt.loadNpmTasks('grunt-sails-linker');
};
