all:
	latexdiff --flatten ./submit/03.tex ./revision/03.tex > 03.tex
	pdflatex 03.tex
	pdflatex 03.tex
	latexdiff --flatten ./submit/04.tex ./revision/04.tex > 04.tex
	pdflatex 04.tex
	pdflatex 04.tex
	latexdiff --flatten ./submit/05.tex ./revision/05.tex > 05.tex
	pdflatex 05.tex
	pdflatex 05.tex
	latexdiff --flatten ./submit/06.tex ./revision/06.tex > 06.tex
	pdflatex 06.tex
	pdflatex 06.tex
	latexdiff --flatten ./submit/07.tex ./revision/07.tex > 07.tex
	pdflatex 07.tex
	pdflatex 07.tex
	latexdiff --flatten ./submit/08.tex ./revision/08.tex > 08.tex
	pdflatex 08.tex
	pdflatex 08.tex
	latexdiff --flatten ./submit/10.tex ./revision/10.tex > 10.tex
	pdflatex 10.tex
	pdflatex 10.tex
clean:
	rm -f *.toc *.aux *.out *.blg *.bbl *.log *.snm *.nav *.tex
