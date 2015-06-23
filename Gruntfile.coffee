# Generated on 2015-06-23 using generator-bower 0.0.1
'use strict'

mountFolder = (connect, dir) ->
    connect.static require('path').resolve(dir)

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  yeomanConfig =
    src: 'src'
    dist : 'dist'
  grunt.initConfig
    yeoman: yeomanConfig


    coffee:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.src %>'
          src: '{,*/}*.coffee'
          dest: '<%= yeoman.dist %>'
          ext: '.js'
        ]
    uglify:
      build:
        src: '<%=yeoman.dist %>/stateful-fastclick.js'
        dest: '<%=yeoman.dist %>/stateful-fastclick.min.js'
    watch: {
      scripts: {
        files: ['<%= yeoman.src %>/{,*/}*.coffee'],
        tasks: ['coffee', 'uglify'],
        options: {
          spawn: false,
        },
      },
    },

    grunt.registerTask 'default', [
      'coffee',
      'uglify',
      'watch'
    ]