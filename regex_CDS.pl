use lib;
use strict;
use warnings;
use v5.10;

my $nume_fisier = undef;
my @continut = undef; #!! se aloca o componenta nedefinita la indexul 0;
my @result = ();
my @CDS = ();

my $n = undef;
$nume_fisier = $ARGV[0]; #@ARGV[0]
open (FISIER, "<$nume_fisier");
@continut = <FISIER>;
close FISIER;
print "\n\n";

my $continut = join "", @continut;
foreach ($continut)
  {
 
  do { 	@result = (@result, $&);
		#@result se incarca cu valoarea exacta a matchului
		
	  }
  while ($_ =~ m/CDS .+?([A-Z]){10}"+/gs)
  }
shift(@result);
@CDS = @result;

#print $#CDS;
#print "\n";
#print "Numarul de componente din array este: ", scalar @CDS,' ca rezultat al instructiunii "scalar @result"',"\n";
#$n = @CDS; # Exploatarea unui array într-un mediu scalar.
#print "Numarul de componente din array este: $n",' ca rezultat al instructiunii "$n = @gresult"',"\n\n";
#print $CDS[0];
#print "\n";
#print "\n";print $CDS[1];
#print "\n";
#print "\n";print $CDS[2];




#foreach (@CDS)
#{
#do 
#{@res = (@res, $_);
#}
#while ($_ =~ /[0-9]/gs)
#until $_ =~ /(\/)/gs)
#shift(@res);
#@NRid = @result;


#}






