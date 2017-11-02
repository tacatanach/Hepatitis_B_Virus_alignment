The repository contains scripts to recreate the analyses presented in the manuscript, "Fully automated sequence alignment methods outperform traditional methods for phylogenetic analysis of hepatitis B viruses"

Scripts

mono.py - Computes the percentage of leaves that must be removed from a subtree to make it monophyletic.  Included is the
	  map of ids to genotypes (file Accession_GI_Genotype.csv). 
	  Usage: python mono.py -g <id_to_genotype> -t <input_tree> -o <output_file>
	  
consensus.pl - creates majority-rules consensus sequence (fasta format) from a fasta file containing multiple full genome sequences
