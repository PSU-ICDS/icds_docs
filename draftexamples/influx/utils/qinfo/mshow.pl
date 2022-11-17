#!/usr/bin/perl
#

use XML::LibXML;

open my $fh, '<', "/tmp/mshow.in";
#open my $fh, '-|', "/opt/moab/bin/showq --blocking --xml";
binmode $fh, ':raw';
my $dom = XML::LibXML->load_xml(IO => $fh);
my $format = "%-10s %-13s %-24s %-10s %10s %5s %12s %13s\n";

my %inflist;
my %jobStats;
foreach my $job ($dom->findnodes('//job')){
#	print "$job\n==\n";
	my %info;
	foreach my $atr ($job->getAttributes){
		$atr =~ s/^\s+//;
		$atr =~ s/"//g;
		my ($tag,$val) = split(/=/,$atr,2);
		$info{$tag} = $val;
#		print "$tag = $val\n";
	}
#	print "========\n";
	next unless ($info{'Account'} eq "cyberlamp");
	my $runlim = sprintf("%dT%02d:%02d:%02d",(gmtime($info{'ReqAWDuration'}))[7,2,1,0]);
	my $left = $info{'ReqAWDuration'} - $info{'AWDuration'};
	my $remain = sprintf("%dT%02d:%02d:%02d",(gmtime(abs($left)))[7,2,1,0]);
	$remain  = "-" . $remain if ($left < 0);
	my $jobinf = sprintf($format, $info{'JobID'}, $info{'User'}, $info{'Account'}, $info{'QOS'},
			     $info{'State'}, $info{'ReqProcs'}, $runlim, $remain);
	push(@{$inflist{$info{'State'}}},$jobinf);
	$jobStats{$info{'State'}} += $info{'ReqProcs'};
}
printf ($format,"JobID", "User", "Acct", "QOS", "State", "Cores", "RunLim", "RunLeft");
printf ($format,("-----") x 8);

foreach my $state ("Running","Suspended","Idle","Deferred","Hold","BatchHold","SystemHold","UserHold"){
	foreach my $job (@{$inflist{$state}}){
		print $job;
	}
	delete($inflist{$state});
}
delete($inflist{Canceling});
delete($jobStats{Canceling});
my $totalJobs =0;
foreach my $state (keys %inflist){
	foreach my $job (@{$inflist{$state}}){
		print "X$job";
	}
	delete($inflist{$state});
}
print "\nTotals Cores in queue:\n";
foreach my $state ("Running","Suspended","Idle"){
	next if ($jobStats{$state} == 0);
	printf "%-10s %6s\n","$state:", $jobStats{$state};
	$totalJobs += $jobStats{$state};
	delete($jobStats{$state});
}
my $otherJobs=0;
foreach my $state (keys %jobStats){
	$otherJobs+= $jobStats{$state};
}
printf "%-10s %6s\n","Others:", $otherJobs;
$totalJobs += $otherJobs;
printf "%-10s %6s\n","Total:", $totalJobs;

my $savesep = $/;
$/ = "\n\n";

open(PBS,"/usr/local/bin/pbsnodes -a|") || die "Can't open PBS input\n";

my @nodes = <PBS>;
close PBS;
$/ = $savesep;
my %nodeInfo;
foreach my $node (@nodes){
        my @props = split(/\n/,$node);
        my $host = shift(@props);
	next unless ($host =~ /^comp-cl/);
	my $nt = "UNK";
	if ($host =~ /comp-cl(..)-/){
		$nt = $1;
	}	
        my %info;
        foreach my $l (@props){
                $l =~ s/^     //;
                $l =~ s/ = /=/;
                my ($k,$v) = split(/=/,$l,2);
                $info{$k} = $v;
        }
	my $state="UNK";
	my ($down,$busy,$idle,$total) = (0,$info{dedicated_threads}, 
					($info{np} - $info{dedicated_threads}),
					 $info{np});
        if ($info{state} =~ /down/ || $info{state} =~ /offline/){
		$down = $idle;
		$idle = 0;
		$state = "Down";
	}
	$nodeInfo{$nt}{down} += $down;
	$nodeInfo{$nt}{busy} += $busy;
	$nodeInfo{$nt}{total} += $total;
	$nodeInfo{$nt}{idle} += $idle;

        if ($info{gpus} > 0){
                @gpus = split(/gpu\[/,$info{gpu_status});
		my ($t,$i,$b,$d) = ($info{gpus},0,0,0);
                foreach my $g (@gpus){
                        if ($g =~ /gpu_state=Unallocated/){
                                $i++;
                        }
                }
		$b = $t - $i;
		if ($state eq "Down"){
			$d = $i;
			$i = 0;
		}
		$nodeInfo{GPU}{down} += $d;
		$nodeInfo{GPU}{busy} += $b;
		$nodeInfo{GPU}{idle} += $i;
		$nodeInfo{GPU}{total} += $t;
        }
	
}
printf "%-6s %4s %4s %4s %4s\n", "Type", "Tot", "Idle", "Busy", "Down";
foreach my $t ("gc", "GPU", "hc", "pc"){
	my @args = ($nodeInfo{$t}{total},
		$nodeInfo{$t}{idle},
		$nodeInfo{$t}{busy},
		$nodeInfo{$t}{down});
	printf "%-6s %4s %4s %4s %4s\n", $t, @args;
}
