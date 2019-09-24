all: stata_packages.txt

stata_packages.txt: calls.do run.sbatch | slurmlogs
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --job-name=install_packages run.sbatch; else stata-se -e calls.do ; fi

slurmlogs:
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi
