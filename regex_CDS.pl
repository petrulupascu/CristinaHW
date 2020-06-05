use lib;
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

##################################################################################################

my $continut1 = join "", @continut;
foreach ($continut1)
  {
  do {@result = (@result, $&);
		#@result se incarca cu valoarea exacta a matchului
	  }
  while ($_ =~ m/CDS .+?([A-Z]){10}"+/gs)
  }
shift(@result);
@CDS = @result;

#print $#CDS;
#print "@CDS";
print "\n";

##################################################################################################

$capat = $#continut;
for ($index=0; $index <= $capat; $index++)
{
	if ($continut[$index] =~ /ORIGIN/)
	{
		@ORIGIN = (@ORIGIN, $continut[$index]);
		while ($continut[$index] !~ m/\/\//i) #identifică sfârsitul portiunii ORIGIN //
		{
			$index++;
			@ORIGIN = (@ORIGIN, $continut[$index]);
		}
	}
}
print "Am terminat de prelucrat sectiunea ORIGIN\n";
print "@ORIGIN";

##################################################################################################
$final = $#ORIGIN;
$idx = -1;
for ($index=0; $index <= $final; $index++)
{
	if ($ORIGIN[$index] =~ /ORIGIN/)
		{
			splice (@ORIGIN, $index, 1);
			$idx++;
		}
	while ($ORIGIN[$index] =~ /[ACGTURYKMSWBDHVN]/ig) #codificare FASTA fără caracterul -
		{
		@SECVENTE[$idx] = @SECVENTE[$idx].$&; #sunt mai multe sectiuni ORIGIN
		}
}
print "@SECVENTE";

##################################################################################################
my @lim_inf_global = ();
my @lim_sup_global = ();
my @numarul_de_limite_per_CDS = ();

foreach(@CDS)
{
	my $idx = -1; #-1 to compensate for extra iteration
	do
	{
		@lim_inf_temp = (@lim_inf_temp, $&);
		$idx++;
	}
	while($_ =~ /\d+(?=\.\.)/gm);
	
	print"$idx\n";
	
	@numarul_de_limite_per_CDS = (@numarul_de_limite_per_CDS, $idx);
	$idx = 0;
	do
	{
		@lim_sup_temp = (@lim_sup_temp, $&);
	}
	while($_ =~ /(?<=\.\.)\d+/gm);

	shift(@lim_inf_temp);
	print"@lim_inf_temp"; 
	@lim_inf_global = (@lim_inf_global, @lim_inf_temp);


	print"\n";
	@lim_sup_global = (@lim_sup_global, @lim_sup_temp);
	@lim_inf_temp = ();
	#@lim_sup_temp = undef;
	 last;	
}

##################################################################################################

#create hash map with CDS as key with empty values

##################################################################################################
$index = 0;
foreach(@numarul_de_limite_per_CDS)
{

	my $nucleotide = "";
	for($i = $index, $i < $_, $i++)
	{
		my $lim_inf = @lim_inf_global[$i];
		my $lim_sup = @lim_sup_global[$i];
		$temp_nucleotide = substr($ORIGIN, $lim_inf, $lim_sup);
		$nucleotide = join($nucleotide, $temp_nucleotide);
	}
	#add the value to the key which is you CDS
	$index = $_;
}

##################################################################################################


foreach(@lim_inf_global)
{
	print "\n";
	print "$_";
	print ".....................................................................\n"
}

foreach(@numarul_de_limite_per_CDS)
{
	print "\n";
	print "$_";
}
##################################################################################################

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






