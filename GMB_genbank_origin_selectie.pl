# Exemplul indică modul în care se citeaste un fisier în formatul GenBank,
# se identifică mai multe portiuni ORIGIN a căror secvente sunt unificate
# într-un singur sir de caractere. Identificarea CDS-urilor se poate face
# ulterior exploatând functia substr() care lucrează pe index.
# Dacă specificati un al doilea fisier ca parametru, în acesta se va
# scrie rezultatul prelucrării sectiunii ORIGIN. Dacă nu-l specificati
# programul nu va scrie nimic afisând un mesaj de avertizare.
# Functionalitatea programului a fost verificată pe un fisier restrâns
# Homo_sapiens.GRCh38.99.chromosome.Y.dummy.dat

$nume_fisier_citire = $ARGV[0];
open (FISIER, "<$nume_fisier_citire");
@continut = <FISIER>;
close FISIER;
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

if ($ARGV[1] eq '')
{
	die "NU ati indicat nici un fisier pentru scrierea datelor, Am terminat!\n";
}
else
{
$nume_fisier_scriere = $ARGV[1];
open (SCRIE, ">>$nume_fisier_scriere");
foreach (@SECVENTE)
{
	$lungime  = length($_);
	print SCRIE "Secventa care urmeaza are $lungime de nucleotide:\n";
	print SCRIE "$_\n\n";
}
close SCRIE;
}
print "@SECVENTE";
