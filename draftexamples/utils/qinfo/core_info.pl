#!/usr/bin/perl

my $savesep = $/;
$/ = "\n\n";

open(PBS,"/usr/local/bin/pbsnodes -a|") || die "Can't open PBS input\n";

my @nodes = <PBS>;
close PBS;
$/ = $savesep;
my ($busy_c, $total_c, $idle_c, $busy_g, $total_g, $idle_g) = (0, 0, 0, 0, 0, 0);
my ($down_nodes, $idle_nodes, $dr_nodes) = (0, 0, 0);
foreach my $node (@nodes){
	my @props = split(/\n/,$node);
	my $host = shift(@props);
	my %info;
	foreach my $l (@props){
		$l =~ s/^     //;
		$l =~ s/ = /=/;
		my ($k,$v) = split(/=/,$l,2);
		$info{$k} = $v;
	}
	if ($info{state} =~ /down/ || $info{state} =~ /offline/){
		if ($info{dedicated_threads} > 0){
			$dr_nodes++;
		} else {
			$down_nodes++;
		}
	} elsif ($info{dedicated_threads} == 0){
		$idle_nodes++;
	}
		
	$busy_c += $info{dedicated_threads};
	$total_c += $info{np};
	$idle_c += ($info{np} - $info{dedicated_threads});
	if ($info{gpus} > 0){
		$total_g += $idle{gpu};
		@gpus = split(/gpu\[/,$info{gpu_status});
		foreach my $g (@gpus){
			if ($g =~ /gpu_state=Unallocated/){
				$idle_g++;
			} else {
				$busy_g++;
			}
		}
	}
}
print "Statistic.AllocCores: $busy_c\n";
print "Message.AllocCores: Allocated Cores\n";
print "Statistic.IdleCores: $idle_c\n";
print "Message.IdleCores: Idle Cores\n";
print "Statistic.AllocGPU: $busy_g\n";
print "Message.AllocGPU: Allocated GPUs\n";
print "Statistic.IdleGPU: $idle_g\n";
print "Message.IdleGPU: Idle GPUs\n";
print "Statistic.IdleNodes: $idle_nodes\n";
print "Message.IdleNodes: Idle Nodes\n";
print "Statistic.DownNodes: $down_nodes\n";
print "Message.DownNodes: Down Nodes\n";
print "Statistic.DrNodes: $dr_nodes\n";
print "Message.DrNodes: Draining Nodes\n";
exit(0);
