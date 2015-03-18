module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        watch:
            css:
                files: 'build/style/*.styl'
                tasks: 'stylus'
            csslint:
                files: 'src/css/*.css'
                tasks: 'csslint'
            js:
                files: 'build/javascript/*.js'
                tasks: 'uglify'
            jshint:
                files: 'src/js/*.js'
                tasks: 'jshint:all'
            html:
                files: 'build/template/*.jade'
                tasks: 'jade'
            img:
                files: 'build/images/*.png'
                tasks: 'imagemin'
            unit:
                files: [
                    'unit/text-main.js',
                    'unit/spec/*Spec.js'
                ]
                tasks: 'test'
        imagemin:
            img:
                options:
                    optimizationLevel: 3
                files:
                    'src/img/icon.png': 'build/images/icon.png'
        stylus:
            complie:
                options:
                    linenos: false,
                    compress: true,
                    import: [
                       'variable.styl',
                       'mixin.styl'
                    ]
                    banner: '\/** \n * <%= pkg.name %> - <%= pkg.description %>\n * version <%= pkg.version %> \n * author <%= pkg.author %> \n * date <%= grunt.template.today() %> \n**/\n'
                files:
                    'src/css/style.css': [
                        'build/style/reset.styl',
                        'build/style/header.styl',
                        'build/style/main.styl',
                        'build/style/footer.styl',
                        'build/style/dialog.styl'
                    ]
        uglify:
            compile:
                options:
                    beautify:
                        width: 120
                        beautify: true
                files:
                    'src/js/main.js': ['build/javascript/main.js']

        jade:
            compile:
                options:
                    pretty: true
                    data:
                        debug: false
                files:
                    'index.html': [
                        'build/template/config.jade',
                        'build/template/index.jade'
                    ]
        csslint:
            options:
                csslintrc: '.csslintrc'
                formatters: [
                   id: 'csslint-xml'
                   dest: 'report/csslint.xml'
                ]
            files:
                options:
                    import: false
                src: 'src/css/*.css'
        jshint:
            options:
                jshintrc: '.jshintrc'
                beautify:
                    width: 80
                    beautify: true
            all: [
                'Gruntfile.js'
                'build/javascript/*.js'
            ],
            grunt: 'Gruntfile.js'
            src: 'src/js/*.js'
            build: 'build/javascript/*.js'
        karma:
            options:
                configFile: 'karma.conf.js'
            normal:
                singleRun: true,
                browsers: ['PhantomJS']
            all:
                browsers: ['Chrome', 'Firefox', 'IE']
        clean:
            test:
                src: ['unit/coverage']
            build:
                src: ['src/css', 'src/img', 'src/js']
            report:
                src: ['report']
        connect:
            dev:
                options:
                    port: 3000
                    hostname: 'localhost'
                    base: ''
                    open: 'http://localhost:3000'
                    keepalive: true

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-imagemin'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-csslint'
    grunt.loadNpmTasks 'grunt-contrib-requirejs'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-karma'

    grunt.registerTask 'reset', ['clean:test', 'clean:build', 'clean:report']
    grunt.registerTask 'server', ['connect:dev']
    grunt.registerTask 'test', ['clean:test', 'karma:normal']
    grunt.registerTask 'hint', ['csslint', 'jshint:all']
    grunt.registerTask 'build', ['imagemin', 'stylus', 'jade', 'uglify']
    grunt.registerTask 'default', ['build', 'hint', 'test', 'server', 'watch']