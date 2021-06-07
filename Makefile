#############################################################################
-include Makefile.options
deploy_dir?=
#############################################################################
dist:
	mkdir -p $@

dist/bundle.js: app/music.js | dist
	browserify app/music.js > $@_
	mv $@_ $@

.build.done: dist/bundle.js dist/alphaTab.min.js dist/alphaTab.css dist/font dist/soundfont dist/la-cucaracha.xml
	touch $@

dist/la-cucaracha.xml: data/la-cucaracha.xml | dist
	cp $< $@

dist/alphaTab.min.js: node_modules/@coderline/alphatab/dist/alphaTab.min.js | dist
	cp $< $@

dist/%: node_modules/@coderline/alphatab/dist/% | dist
	cp -r $< $@

dist/alphaTab.css: css/alphaTab.css | dist
	cp $< $@

compile: .build.done | dist
#############################################################################
serve:
	npm start

prepare:
	npm install
#############################################################################
$(deploy_dir)/dist:
	mkdir -p $@

copy_deploy: | $(deploy_dir)/dist
	cp index.html $(deploy_dir)/
	cp -r dist/* $(deploy_dir)/dist/
#############################################################################
clean: 
	rm -rf dist
	rm -rf node_modules
