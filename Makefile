COVERDE_IN=coverletter_de
COVERDE_OUT=JingXu_Anschreiben_2020

RESUMEDE_IN=resume_de
RESUMEDE_OUT=JingXu_Lebenslauf_2020

COVEREN_IN=coverletter_en
COVEREN_OUT=JingXu_Motivation_2020

RESUMEEN_IN=resume_en
RESUMEEN_OUT=JingXu_CV_2020

OUTPUT="output/"

.PHONY: cover_de resume_de clean depclean 

#-----------------------------------------------------------
# cover_de
#-----------------------------------------------------------
cover_de : $(COVERDE_OUT).pdf

$(COVERDE_OUT).pdf: $(COVERDE_IN).tex 
	lualatex -synctex=1 -interaction=nonstopmode $(COVERDE_IN).tex
	mv $(COVERDE_IN).pdf $(OUTPUT)$(COVERDE_OUT).pdf

#-----------------------------------------------------------
# resume_de
#-----------------------------------------------------------
resume_de : $(RESUMEDE_OUT).pdf

$(RESUMEDE_OUT).pdf: $(COVERDE_IN).tex
	lualatex -synctex=1 -interaction=nonstopmode $(RESUMEDE_IN).tex
	mv $(RESUMEDE_IN).pdf $(OUTPUT)$(RESUMEDE_OUT).pdf

#-----------------------------------------------------------
# cover_en
#-----------------------------------------------------------
cover_en : $(COVEREN_OUT).pdf

$(COVEREN_OUT).pdf: $(COVEREN_IN).tex 
	lualatex -synctex=1 -interaction=nonstopmode $(COVEREN_IN).tex
	mv $(COVEREN_IN).pdf $(OUTPUT)$(COVEREN_OUT).pdf

#-----------------------------------------------------------
# resume_en
#-----------------------------------------------------------
resume_en : $(RESUMEEN_OUT).pdf

$(RESUMEEN_OUT).pdf: $(COVEREN_IN).tex
	lualatex -synctex=1 -interaction=nonstopmode $(RESUMEEN_IN).tex
	mv $(RESUMEEN_IN).pdf $(OUTPUT)$(RESUMEEN_OUT).pdf

#-----------------------------------------------------------
# resume
#-----------------------------------------------------------
cover_resume_de:  cover_de resume_de clean

cover_resume_en:  cover_en resume_en clean

all: cover_de resume_de cover_en resume_en clean


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
