#!/usr/bin/perl
#

my $savesep = $/;
$/ = "Job Id: ";
#unless (open(IN,"qstat -f|")){
#	exit(1);
#}

open(IN,"/tmp/qso");

my @jobs = <IN>;
close IN;
$/ = $savesep;

shift(@jobs);
my %qjobs;
foreach my $jobrec (@jobs){
	my @recs = split(/\n/,$jobrec);
	chomp @recs;
	my $jobid = shift(@recs);
	my %info;
	foreach my $line (@recs){
		$line =~ s/^    //g;
		$line =~ s/ = /=/;
		my ($tag,$val) = split(/=/,$line,2);
		$info{$tag} = $val;
	}
	my $nodes = 1;
	my $ppn = 1;
	my $cores = 1;
	if ($info{'Resource_List.nodes'} =~ /(\d+):ppn=(\d+)/){
		($nodes,$ppn) = ($1,$2);
	}
	if ($nodes && $ppn){
		$cores = $nodes * $ppn;
	}
	my $q = $info{'queue'};
	my $s = $info{'job_state'};
	next if ($s eq "C" or $s eq "E");
	if ($s eq "H" or $s eq "W" or $s eq "T" or $s eq "Q"){
		$s = "Pending";
	} elsif ( $s eq "R" ){
		$s = "Run";
	} elsif ( $s eq "S" ){
		$s = "Suspend";
	}
	$qjobs{$q}{$s}{jobs}++;
	$qjobs{$q}{$s}{cores} += $cores;
	$qjobs{total}{$s}{jobs}++;
	$qjobs{total}{$s}{cores} += $cores;
}

foreach my $s ( "Run", "Suspend", "Pending" ){
	print "Statistic.${s}Cores: $qjobs{total}{$s}{cores}\n";
	print "Statistic.${s}Jobs: $qjobs{total}{$s}{jobs}\n";
	print "Message.${s}Cores: ${s} Cores\n";
	print "Message.${s}Jobs: ${s} Jobs\n";
}
exit(0);

