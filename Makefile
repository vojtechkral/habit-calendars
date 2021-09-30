
CHROME = chromium
HTMLS = $(wildcard html/*.html)
PDFS = $(patsubst html/%.html, pdf/%.pdf, $(HTMLS))

.PHONY: all
all: html/.depend $(PDFS)

html/.depend: src/generate.py
	src/generate.py
	touch $@
	$(MAKE) -C .

pdf/%.pdf: html/%.html
	$(CHROME) --headless --print-to-pdf=$@ $<

.PHONY: clean
clean:
	rm -f html/.depend html/*.html pdf/*.pdf 
