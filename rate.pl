#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Chess::Elo qw(:all);
use Text::CSV::Simple;

@ARGV == 2 or die("Invalid argument.");

my ($ratingFile, $resultFile) = @ARGV;

my $ratingParser = Text::CSV::Simple->new();
my @ratingData = $ratingParser->read_file($ratingFile);

my $resultParser = Text::CSV::Simple->new();
my @resultData = $resultParser->read_file($resultFile);

my %ratingTable;
foreach my $record (@ratingData){
	$ratingTable{$record->[0]} = $record->[1];
}

foreach my $result (@resultData){
	my ($rating1, $rating2) = elo($ratingTable{$result->[0]}, $result->[4], $ratingTable{$result->[3]});
	$ratingTable{$result->[0]} = $rating1;
	$ratingTable{$result->[3]} = $rating2;
}

foreach my $key (keys(%ratingTable)){
	print("$key,$ratingTable{$key}\n");
}
