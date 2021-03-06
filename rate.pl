#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Chess::Elo qw(:all);
use Text::CSV::Simple;

@ARGV == 3 or die("Invalid argument.");

my ($k, $ratingFile, $resultFile) = @ARGV;
$Chess::Elo::factor = $k;

my $ratingParser = Text::CSV::Simple->new();
my @ratingData = $ratingParser->read_file($ratingFile);

my $resultParser = Text::CSV::Simple->new();
my @resultData = $resultParser->read_file($resultFile);

my %ratingTable;
foreach my $recode (@ratingData){
	$ratingTable{$recode->[0]} = $recode->[1];
}

foreach my $result (@resultData){
	my ($rating1, $rating2) = elo($ratingTable{$result->[2]}, $result->[6], $ratingTable{$result->[5]});
	$ratingTable{$result->[2]} = $rating1;
	$ratingTable{$result->[5]} = $rating2;
}

foreach my $key (keys(%ratingTable)){
	print("$key,$ratingTable{$key}\n");
}
