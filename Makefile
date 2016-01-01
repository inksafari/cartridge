# Thanks
# - https://github.com/N4M3Z/LaTeXCore/latexmkrc
# - http://konn-san.com/prog/why-not-latexmk.html
# - https://github.com/weijianwen/SJTUThesis/blob/master/Makefile

DEFAULT_SRC = main.tex
TEX_SOURCES = $(wildcard *.tex) $(wildcard *.bib) $(wildcard content/*.tex) $(wildcard content/**/*.tex)
OUTPUT_NAME = $(shell date +%F)           # 2011-11-30
NOW         = $(shell date +"%F %R %Z")   # 2011-11-30 22:33 CST

all: $(OUTPUT_NAME).pdf

lint:
	xelatex -no-pdf -halt-on-error $(TEX_SOURCES)
	biber --debug %O %S $(TEX_SOURCES)

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -use-make tells latexmk to call make for generating missing files.
$(OUTPUT_NAME).pdf:$(DEFAULT_SRC)
	@latexmk -silent -pvc -pdf -use-make $<
	@echo "Success!"

watch:
	@while ! inotifywait --event modify $(TEX_SOURCES); do make; done

# sudo aptitude install hunspell
spell:
	@hunspell -l -t -d en_US -i utf-8 $(TEX_SOURCES) | sort | uniq --ignore-case

# wordcount
wc:
	@texcount $(DEFAULT_SRC) -inc          | awk '/total/ {getline; print "詞數:",$$4}' 
	@texcount $(DEFAULT_SRC) -inc -ch-only | awk '/total/ {getline; print "Words:",$$4}'
	@texcount $(DEFAULT_SRC) -inc -char    | awk '/total/ {getline; print "Total Count:",$$4}' 
	@sh files/count.sh

# chinese word counter (檔名不能有中文)
# https://github.com/chenshuo/recipes/tree/master/utility
cwc:
	@echo "Lines, Chinese, Bytes"
	@files/cwc $(TEX_SOURCES) 

clean:
	@latexmk -c
	@echo "Cleaning complete!"

# 一併刪除 PDF，使用 latexmk -C
cleanall:
	@latexmk -C
	@find . -type f -name "*~" -exec rm {} \; # clean Gedit backup files
	@rm -f *.synctex.gz(busy)
	@rm -f *.synctex.gz
	@echo "Cleaning complete!"

git:
	git add -A && git commit -m "Update at $NOW" && git push origin master

.PHONY: $(OUTPUT_NAME).pdf all watch clean spell wc cwc