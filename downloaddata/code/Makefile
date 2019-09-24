#Definitions
folders   = ../output
OES_data  = ../output/msa_2000_dl_1.xls ../output/msa_2000_dl_2.xls
downloads = ../output/cbp00msa.txt $(OES_data)

#Recipes
all: $(folders) $(downloads)

../output:
	mkdir $@

#County Business Patterns for MSAs
../output/cbp00msa.txt: | $(folders)
	curl https://www2.census.gov/Econ2001_And_Earlier/CBP_CSV/cbp00msa.zip > cbp00msa.zip
	unzip cbp00msa.zip
	mv cbp00msa.txt ../output/
	rm cbp00msa.zip

#Occupational Employment Statistics for MSAs
$(OES_data): | $(folders)
	curl https://www.bls.gov/oes/special.requests/oes00ma.zip > oes00ma.zip
	unzip oes00ma.zip
	mv msa_2000_dl_1.xls msa_2000_dl_2.xls ../output/
	rm oes00ma.zip
