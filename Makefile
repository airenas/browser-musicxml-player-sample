#############################################################################
-include Makefile.options
deploy_dir?=
#############################################################################
.build.done: public/at/LICENSE.alphaTab public/at/alphaTab.min.js public/at/font \
	public/at/soundfont
	touch $@

public/at/alphaTab.min.js: node_modules/@coderline/alphatab/dist/alphaTab.min.js 
	cp $< $@
public/at/LICENSE.alphaTab: node_modules/@coderline/alphatab/LICENSE
	cp $< $@	
public/at/%: node_modules/@coderline/alphatab/dist/% 
	cp -r $< $@

compile: .build.done 
	npm run build
#############################################################################
serve: .build.done 
	npm run serve

prepare:
	npm install

#############################################################################
clean-deploy: 
	rm -rf $(deploy_dir)/at $(deploy_dir)/css $(deploy_dir)/js
	rm -f $(deploy_dir)/index.html $(deploy_dir)/favicon.icoma


copy-deploy: clean-deploy
	cp -r dist/* $(deploy_dir)/
#############################################################################
clean: 
	rm -rf dist
	rm -rf node_modules
