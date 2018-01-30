#!/usr/bin/env perl

use strict;
use warnings;

`ls -l *.tre >filenames`;

open FH, "<filenames";
while (<FH>) {
	if (/(\S+).tre/) {
		my $file=$1;
		#`tr '\r' '\n' < $file.tre > $file.lb.tre`;
		open FH1, "<$file.tre";
		open OUT, ">$file.brlens.csv";
		while (<FH1>) {
			my $line=$_;
			#print "$line\n";
			while ($line =~ m/(\S+)(gi\d+:0.\d+)(\S+)/) {
				#print "$line\n\n";
				my $beg=$1;
				my $brlen=$2;
				my $end=$3;
				#print "BEGINNING $beg\n BRANCHLENGTH $brlen\n END $end\n";
				print OUT "$brlen\n";
				$line = $beg;
			}
		}
	}
}
