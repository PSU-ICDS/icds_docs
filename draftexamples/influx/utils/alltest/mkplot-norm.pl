#!/usr/bin/perl

my ($file,$low, $high, $val1, $val2) = @ARGV;

unless(open(IN,"$file")){
	die "Can't open file '$file'\n";
}

open(TMP,">/tmp/gbstmp.$$");

print TMP qq^
set terminal postscript portrait color
set output 'out.$$.ps'
set view map
set cbrange [ $low : $high ]
set cblabel "Latency in usec"
set xlabel "Rank"
set ylabel "Rank"
set title "Latency by Process Pairs"
set palette defined (0 "blue", 1 "green", 2 "yellow",  4 "red")
set size square
set xrange [ $val1 : $val2 ]
set yrange [ $val1 : $val2 ]
^;

my $step = ($high - $low)/8;

print TMP qq^set cbtics border 10,0.1 ("$low" $low, ^;
for($point = $low+$step;$point < $high; $point += $step){
	printf TMP qq^"%0.02f" $point, ^, $point;
}
print TMP qq^"$high" $high)\n^;

print TMP "plot '$file' using 1:2:4 notitle with image\n";
print TMP "quit\n";
close TMP;

system("gnuplot < /tmp/gbstmp.$$");
system("convert out.$$.ps -crop 504x504+0+108 $file.png");
#system("rm /tmp/gbstmp.$$ out.$$.ps");



