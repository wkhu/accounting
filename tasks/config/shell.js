/**
 * Run predefined tasks whenever watched file patterns are added, changed or deleted.
 *
 * ---------------------------------------------------------------
 *
 * Creates a symlink to .tmp/public/ folders namely: pdf and interactive
 * from static folder everytime the server reboots.
 */
module.exports = function(grunt) {
  grunt.config.set('shell', {
    dev: {
      command: "./LINK.sh",
      options: {
        stdout: true
      }
    }
  });

  grunt.loadNpmTasks('grunt-shell');
};
