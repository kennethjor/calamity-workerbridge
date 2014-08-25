fs = require "fs"
gulp = require "gulp"
sourcemaps = require "gulp-sourcemaps"
concat = require "gulp-concat"
coffee = require "gulp-coffee"
uglify = require "gulp-uglify"
wrapper = require "gulp-wrapper"
replace = require "gulp-replace"
jade = require "gulp-jade"
bower = require "main-bower-files"

pkg = JSON.parse fs.readFileSync "package.json"

gulp.task "compile-main", ->
	gulp.src "./src/calamity-workerbridge.coffee"
		.pipe sourcemaps.init
			loadMaps: true
		.pipe coffee
			bare: true
		.pipe wrapper
			header: "/*! #{pkg.fullname} #{pkg.version} - MIT license */\n" + "(function(){\n" + fs.readFileSync "src/init.js"
			footer: "}).call(this);"
		.pipe replace "%version%", pkg.version
		.pipe sourcemaps.write ".",
			includeContent: true
		.pipe gulp.dest "."

gulp.task "compile-worker", ->
	gulp.src "./src/calamity-workerbridge-worker.coffee"
		.pipe sourcemaps.init
			loadMaps: true
		.pipe coffee
			bare: true
		.pipe wrapper
			header: "/*! #{pkg.fullname} (worker) #{pkg.version} - MIT license */\n" + "(function(){\n"
			footer: "}).call(this);"
		.pipe sourcemaps.write ".",
			includeContent: true
		.pipe gulp.dest "."

gulp.task "compile", ["compile-main", "compile-worker"]



gulp.task "test-jade", ->
	gulp.src "./test/*.jade"
		.pipe jade()
		.pipe gulp.dest "build/"

gulp.task "test-deps", ->
	bowerFiles = bower()
	bowerFiles.push "calamity-workerbridge.js"
	bowerFiles.push "calamity-workerbridge-worker.js"
	#console.log bowerFiles
	gulp.src bowerFiles
		.pipe gulp.dest "build/"

gulp.task "test-compile", ["compile"], ->
	gulp.src "./test/index.coffee"
		.pipe coffee
			bare: true
		.pipe gulp.dest "build/"

gulp.task "test", ["test-jade", "test-deps", "test-compile"]

gulp.task "watch", ->
	gulp.watch ["src/*", "test/*"], ["default"]

gulp.task "default" , ["compile", "test"]
