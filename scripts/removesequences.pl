#!/usr/bin/env perl

use strict;
use warnings;

my $countunique=0;
my $countoverlap=0;
my $total=0;
my %taxhash=();


open BADS, ">Sequences_to_remove_Round0_txt";
open FH, "<Results.txt";
while (<FH>) {
	if (/(gi\S+)/) {
		my $tax=$1;
		$total++;
		if (! exists $taxhash{$tax}) {
			$taxhash{$tax}=1;
			$countunique++;
			print BADS "$tax\n";
		}
		#else { $countoverlap++; }	
	}
}
print "$total\t$countunique\n";

my $total2=0;
open FH1, "<PotentiallyBadSeqs.txt";
while (<FH1>) {
	if (/(gi\S+)/) {
		$total2++;
		my $tax=$1;
		if (! exists $taxhash{$tax}) {
			$taxhash{$tax}=1;
			$countunique++;
			print BADS "$tax\n";
		}
		else { $countoverlap++; }	
	}
}
print "$total2\t$countunique\t$countoverlap\n";


#my $countfound=0;
#my $path="/Users/julieallen/Box\ Sync/HBV_files_and_alignments/Full_Alignments";
#open SEQ, "<$path\/Final_Alignment_Linearized.Nov.6.2014.CleanNames.DuplicatesRemoved.phy";
#open OUT, ">$path\/Final_Alignment_Linearized.Nov.6.2014.CleanNames.DuplicatesRemoved.Round1.phy";
#while (<SEQ>) {
	#print;
#	if (/(\d+)\s+(\d+)/) {
#
#my $tottax=$1;
#		my $length=$2;
#		my $newtax = $tottax - $countunique;
#		print OUT "$newtax\t$length\n";
#		print "$newtax\t$length\n";
#	}
#	elsif (/(\S+)\s+(\S+)/) {
#		my $tax=$1;
#		my $seq=$2;
#		if (! exists $taxhash{$tax}) {
#			print OUT;
#		}
#		else { $countfound++; print "$tax\n"; }
#	}
#}

#print "There were $countfound sequences removed from the big file\n";
		
