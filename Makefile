TARGET = interview-book.pdf
SRC = $(shell cat outline.txt)
ID = $(shell git rev-parse --short HEAD)
TARGETDIR = build
PDFOPTIONS = --latex-engine xelatex \
	--variable monofont='Monaco' \
	--variable mainfont='Garamond Premier Pro' \
	--variable sansfont='Frutiger LT Std' \
	--variable fontsize=10pt \
	--variable documentclass=scrbook \
	--include-in-header header.tex \
	--table-of-contents \
	--toc-depth=2

all: pdf
	@echo "Done!"

$(TARGETDIR)/$(TARGET)-$(ID).tex: $(TARGETDIR)
	pandoc $(SRC) $(PDFOPTIONS) -o $(TARGETDIR)/$(TARGET)-$(ID).tex

pdf: $(TARGETDIR) $(TARGETDIR)/$(TARGET)-$(ID).tex
	xelatex -shell-escape -output-directory=$(TARGETDIR) \
		$(TARGETDIR)/$(TARGET)-$(ID).tex

$(TARGETDIR):
	mkdir build

.PHONY: clean

clean:
	rm -rf $(TARGETDIR)

rebuild: clean all
