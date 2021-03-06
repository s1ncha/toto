#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Readonly;
use Chess::Elo qw(:all);
use Text::CSV::Simple;

Readonly my $W => 0;
Readonly my $D => 0.05;

@ARGV == 3 or die("Invalid argument.");

my ($ratingFile, $team1, $team2) = @ARGV;

my $ratingParser = Text::CSV::Simple->new();
my @ratingData = $ratingParser->read_file($ratingFile);

my %ratingTable;
foreach my $record (@ratingData){
        $ratingTable{$record->[0]} = $record->[1];
}

my $p = 1 / (10 ** -(($ratingTable{$team1} - $ratingTable{$team2}) / 400) + 1);
print("$team1($ratingTable{$team1}) vs $team2($ratingTable{$team2})\n");
print(($p > 0.5 + $W ? "1" : "-") . ($p < 0.5 + $D && $p > 0.5 - $D ? "0" : "-") . ($p < 0.5 - $W ? "2" : "-") . "\n");
