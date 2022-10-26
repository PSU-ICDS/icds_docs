#!/usr/bin/perl
#

my $rank = $ENV{SLURM_PROCID};
my $hostname=`/bin/hostname`;
chomp $hostname;
my $slot=$ENV{SLURM_LOCALID};

print "rank $rank=$hostname slot=$slot\n";


