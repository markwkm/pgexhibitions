.PHONY: all clean

MAINMATTER = document.tex
#NAME := $(shell sed -n -e "s/ /-/g; s/\\\\title{\(.*\)}/\L\1/p" $(MAINMATTER))
NAME := postgresql-community-exhibitions

# xetex (or luatex) is required to use ariel
MYLATEX=xelatex

all: $(NAME).pdf $(NAME)-with-notes.pdf

%.png: %.gv
	dot -Tpng -o $@ $<

$(NAME).pdf: slides.tex $(MAINMATTER) Makefile \
		$(patsubst %.gv, %.png, $(wildcard *.gv))
	TEXINPUTS=Templates:$$TEXINPUTS $(MYLATEX) -output-format=pdf \
			  -jobname=$(NAME) $<
	TEXINPUTS=Templates:$$TEXINPUTS $(MYLATEX) -output-format=pdf \
			  -jobname=$(NAME) $<
	-rm $(basename $@).aux $(basename $@).log $(basename $@).nav \
			$(basename $@).out $(basename $@).snm $(basename $@).toc

$(NAME)-with-notes.pdf: slides-with-notes.tex $(MAINMATTER) Makefile \
		$(patsubst %.gv, %.png, $(wildcard *.gv))
	TEXINPUTS=Templates:$$TEXINPUTS $(MYLATEX) -output-format=pdf \
			  -jobname=$(NAME)-with-notes $<
	TEXINPUTS=Templates:$$TEXINPUTS $(MYLATEX) -output-format=pdf \
			  -jobname=$(NAME)-with-notes $<
	-rm $(basename $@).aux $(basename $@).log $(basename $@).nav \
			$(basename $@).out $(basename $@).snm $(basename $@).toc

clean:
	-rm -f *.pdf
	-rm -f $(NAME).aux $(NAME).log $(NAME).nav $(NAME).out $(NAME).snm \
			$(NAME).toc
	-rm -f $(NAME)-with-notes.aux $(NAME)-with-notes.log \
			$(NAME)-with-notes.nav $(NAME)-with-notes.out \
			$(NAME)-with-notes.snm $(NAME)-with-notes.toc
