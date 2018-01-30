#!usr/bin/env perl

use strict;
use warnings;


my $cutoff=0.2;
my %taxhash=();
my @taxarray=();
`ls -l *.csv >files`;
open FH, "<files";
while (<FH>) {
	if (/(\S+).csv/) {
		my $file=$1;
		open FH1, "<$file.csv";
		while (<FH1>) {
			if (/(\S+):(\S+)/) {
				my $tax=$1;
				my $bl = $2;
				if ($bl > $cutoff) {
					if (! exists $taxhash{$tax}) {
						$taxhash{$tax}=1;
						push @taxarray, $tax;
					}
					else { $taxhash{$tax}++; }
				}
			}
		}
	}
}

my $total = scalar(@taxarray);

for my $tax(@taxarray) {
	print "$tax\t$taxhash{$tax}\n";
}

print "There are $total tax with bl => $cutoff.\n";



