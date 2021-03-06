module.exports = (grunt) ->

  grunt.initConfig
    package: grunt.file.readJSON 'package.json'
    outputFileName: '<%= package.name %>-<%= package.version %>'

    coffeelint:
      all:
        src: ['source/*.coffee', 'tests/*.coffee']

    clean:
      all: ['distribution/*']

    coffee:
      all:
        expand: yes
        cwd: 'source/'
        src: ['*.coffee']
        dest: 'distribution/'
        ext: '.js'

    browserify2:
      compile:
        options:
          expose:
            'data-structures': './distribution/index.js'
        entry: './distribution/index.js'
        compile: 'distribution/browser/<%= outputFileName %>.js'

    uglify:
      all:
        src: ['distribution/browser/<%= outputFileName %>.js']
        dest: 'distribution/browser/<%= outputFileName %>.min.js'

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-browserify2'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['coffeelint', 'clean', 'coffee',
                                 'browserify2', 'uglify']
