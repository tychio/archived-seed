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
                files: 'build/coffee/*.coffee'
                tasks: 'coffee'
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
                tasks: 'karma:normal:run'
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
        jade:
            compile:
                options:
                    pretty: true
                    data:
                        debug: false
                files:
                    'index.html': [
                        'build/template/header.jade',
                        'build/template/index.jade'
                    ]
        coffee:
            compile:
                files:
                    'src/js/main.js': 'build/coffee/main.coffee'
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
                browsers: ['Chrome']
            all:
                browsers: ['Chrome', 'Firefox', 'IE']

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-imagemin'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-csslint'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-karma'

    grunt.registerTask 'test', ['karma:all']
    grunt.registerTask 'hint', ['csslint', 'jshint:all']
    grunt.registerTask 'compile', ['imagemin', 'stylus', 'jade', 'coffee']
    grunt.registerTask 'default', ['jshint:all', 'compile', 'csslint', 'karma:normal','watch']