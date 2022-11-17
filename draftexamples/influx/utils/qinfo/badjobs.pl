#!/usr/bin/perl
#

my $savesep = $/;
$/ = "Job Id: ";
unless (open(IN,"sudo /usr/local/bin/qstat -f1|")){
       exit(1);
}

#open(IN,"/tmp/qso");

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
	if ($info{'Resource_List.nodes'} =~ /(\d+).*:ppn=(\d+)/){
		($nodes,$ppn) = ($1,$2);
	} else {
		$ppn = $info{'req_information.task_usage.0.task.0.threads'};
	}
	
	next unless ($info{job_state} eq 'R');
	my $threads = $info{'req_information.task_usage.0.task.0.threads'};
	if ($threads != $ppn){
		print "$jobnum [$info{'start_time'}] neednodes=$info{'Resource_List.nodes'} req_information.threads=$threads - ";
		print "$info{'exec_host'} -> $info{'req_information.task_usage.0.task.0.cpu_list'}\n";
	}
}

