#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Chess::Elo qw(:all);
use Text::CSV::Simple;

@ARGV == 3 or die("Invalid argument.");

my ($ratingFile, $team1, $team2) = @ARGV;

my $ratingParser = Text::CSV::Simple->new();
my @ratingData = $ratingParser->read_file($ratingFile);

my %ratingTable;
foreach my $record (@ratingData){
	$ratingTable{$record->[0]} = $record->[1];
}

my $p = 1 / (10 ** -(($ratingTable{$team1} - $ratingTable{$team2}) / 400) + 1);
print("$team1($ratingTable{$team1}) vs $team2($ratingTable{$team2}) : $p\n");  
