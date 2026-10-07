MAIN ?= main.tex

.PHONY: all clean distclean

all:
	latexmk -xelatex $(MAIN)

clean:
	latexmk -c $(MAIN)

distclean:
	latexmk -C $(MAIN)
