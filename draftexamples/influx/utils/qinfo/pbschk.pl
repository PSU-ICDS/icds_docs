#!/usr/bin/perl
#

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
#	next unless ($host =~ /comp-cl/);
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
	my $allocs=0;
	if ($info{jobs} =~ /\d+/){
		my $line = $info{jobs};
		$line =~ s/\[\d+\]//g;
		$line =~ s/\/\d+\.torque01.util.production.int.aci.ics.psu.edu//g;
		$line =~ s/\-/../g;
		my @a = eval($line);
		$allocs = scalar @a;
	}
	if ($info{dedicated_threads} > $allocs){
		print "$host = $allocs\n";
		print $node;
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
exit(0);
printf "%-6s %4s %4s %4s %4s\n", "Type", "Tot", "Idle", "Busy", "Down";
foreach my $t ("gc", "GPU", "hc", "pc"){
	my @args = ($nodeInfo{$t}{total},
		$nodeInfo{$t}{idle},
		$nodeInfo{$t}{busy},
		$nodeInfo{$t}{down});
	printf "%-6s %4s %4s %4s %4s\n", $t, @args;
}
