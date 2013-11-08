
.PHONY: all paper clean

all: paper

paper:
	@command -v rubber >/dev/null 2>&1 || { \
		cd paper; \
		pdflatex symmetry.tex; \
		bibtex symmetry.aux; \
		pdflatex symmetry.tex; \
		pdflatex symmetry.tex; \
		exit 0; \
	}
	@cd paper && rubber -d symmetry.tex

clean:
	-@cd paper && rm *.aux *.log *.bbl *.blg *.tdo *.out
