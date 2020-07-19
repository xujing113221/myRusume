COVERDE_IN=coverletter_de
COVERDE_OUT=JingXu_Anschreiben_2020

RESUMEDE_IN=resume_de
RESUMEDE_OUT=JingXu_Lebenslauf_2020

RESUMEEN=resume_en

.PHONY: cover_de resume_de clean depclean 

#-----------------------------------------------------------
# cover_de
#-----------------------------------------------------------
cover_de : $(COVERDE_OUT).pdf

$(COVERDE_OUT).pdf: $(COVERDE_IN).tex 
	lualatex -synctex=1 -interaction=nonstopmode $(COVERDE_IN).tex
	mv $(COVERDE_IN).pdf $(COVERDE_OUT).pdf

#-----------------------------------------------------------
# resume_de
#-----------------------------------------------------------
resume_de : $(RESUMEDE_OUT).pdf

$(RESUMEDE_OUT).pdf: $(COVERDE_IN).tex
	lualatex -synctex=1 -interaction=nonstopmode $(RESUMEDE_IN).tex
	mv $(RESUMEDE_IN).pdf $(RESUMEDE_OUT).pdf

#-----------------------------------------------------------
# resume
#-----------------------------------------------------------
cover_resume_de:  cover_de resume_de clean


#-----------------------------------------------------------
# clean & depclean
#-----------------------------------------------------------
clean:
	-@rm -f \
		*~ \
		*.aux \
		*.bbl \
		*.blg \
		*.log \
		*.out \
		*.bcf \
		*.xml \
		*.gz \
		*.fdb_latexmk\
		*.fls\
		__latexindent_temp.tex


depclean: clean
	-@rm -f \
		*.pdf
