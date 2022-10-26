#!/usr/bin/perl
#

my $savesep = $/;
$/ = "Job Id: ";
#unless (open(IN,"qstat -f|")){
#       exit(1);
#}

open(IN,"/tmp/qso");

my @jobs = <IN>;
close IN;
$/ = $savesep;

shift(@jobs);
my %inflist;
foreach my $jobrec (@jobs){
	my @recs = split(/\n/,$jobrec);
	chomp @recs;
	my $jobid = shift(@recs);
	my ($jobnum) = split(/\./,$jobid);
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
	my $format = "%-9s %-13s %-24s %s %11s %11s\n";
	my $jobinf = sprintf($format, $jobnum, $info{'euser'}, $info{'Account_Name'}, $info{'job_state'},
			     $info{'Resource_List.walltime'}, $info{'resources_used.walltime'});
	push(@{$inflist{$info{'job_state'}}},$jobinf);
}
foreach my $state ("R","S","Q","H","W"){
	foreach my $job (@{$inflist{$state}}){
		print $job;
	}
}

