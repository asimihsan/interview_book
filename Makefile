TARGET = interview-book
SRC = $(shell cat outline.txt)
TARGETDIR = build
PDFOPTIONS = --latex-engine xelatex \
	--variable monofont='Monaco' \
	--variable mainfont='Garamond Premier Pro' \
	--variable sansfont='Frutiger LT Std' \
	--variable fontsize=10pt \
	--variable documentclass=scrbook \
	--include-in-header header.tex \
	--table-of-contents \
	--toc-depth=2 \
	--filter ./graphviz.py \
	--verbose

all: pdf
	@echo "Done!"

$(TARGETDIR)/$(TARGET).tex: $(TARGETDIR)
	pandoc $(SRC) $(PDFOPTIONS) -o $(TARGETDIR)/$(TARGET).tex

pdf: $(TARGETDIR) $(TARGETDIR)/$(TARGET).tex
	xelatex -shell-escape -output-directory=$(TARGETDIR) \
		$(TARGETDIR)/$(TARGET).tex && \
	xelatex -shell-escape -output-directory=$(TARGETDIR) \
		$(TARGETDIR)/$(TARGET).tex

$(TARGETDIR):
	mkdir build

.PHONY: clean

clean:
	rm -rf $(TARGETDIR)

rebuild: clean all
