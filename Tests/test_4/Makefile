.PHONY: all

all:
	number=1 ; while [ $$number -le 30 ] ; do \
		echo $$number ; \
		cp exam.tex $$number.tex ; \
		pdflatex $$number.tex ; \
		pythontex $$number.tex ; \
		pdflatex $$number.tex ; \
		latexmk -c ; \
		rm $$number.pytxcode ; \
		rm $$number.tex ; \
		number=$$((number + 1)) ; \
	done