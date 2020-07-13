use strict;
use File::Copy 'copy';
my $program = 'generate';
my $version = '0.2.0';
my $mod_date = '2020/07/13';
my $prefix = 'tccm';
my $outbase = 'tccomicsans';
my $tempb = '__tccm';

my (@mapline);
sub main {
  oneshape('rcomic8r', '8r.enc', 'comic.ttf');
  oneshape('rcomicbd8r', '8r.enc', 'comicbd.ttf');
  oneshape('rcomiccyr', 't2a.enc', 'comic.ttf');
  oneshape('rcomiccyrbd', 't2a.enc', 'comicbd.ttf');
  oneshape('rcomic7m', 'texmital.enc', 'comic.ttf');
  oneshape('rcomicbd7m', 'texmital.enc', 'comicbd.ttf');
  oneshape('rcomic7y', 'texmsym.enc', 'comic.ttf');
  oneshape('rcomic9z', 'csextras.enc', 'comic.ttf');
  # bonus
  oneshape('rcomico8r', '8r.enc', 'comici.ttf');
  oneshape('rcomicbdo8r', '8r.enc', 'comicz.ttf');
  oneshape('rcomiccyro', 't2a.enc', 'comici.ttf');
  oneshape('rcomiccyrbdo', 't2a.enc', 'comicz.ttf');
  # write map file
  write_whole("$outbase.map", join('', @mapline));
}

sub oneshape {
  my ($tfm, $encf, $fntf) = @_; local ($_);
  my $nenc = "$prefix-$encf"; $nenc =~ s/.enc$//;
  push(@mapline, <<"EOT");
$tfm ComicSansMS "$nenc-enc ReEncodeFont" <[$nenc.enc <$fntf
EOT
  (-f "$nenc.enc") and return;
  # make a new enc file
  my $fntexist = (-f $fntf);
  if (!$fntexist) {
    copy(kpse($fntf), $fntf) or error("copy failure", $fntf);
  }
  system('otftotfm', '--no-dotlessj', '--no-type1',
    '-e', $encf, $fntf, $tempb);
  ($? == 0) or error("otftotfm failure", $tfm);
  my @gencf = glob("a_*.enc");
  (scalar(@gencf) == 1) or error("otftotfm failure", $tfm);
  $_ = read_enc($gencf[0]) or error("bad enc file", $gencf[0]);
  $_ = join("\n", @$_);
  write_whole("$nenc.enc", <<"EOT");
/$nenc-enc [
$_
] def
EOT
  unlink($gencf[0], glob("$tempb*.*"));
  if (!$fntexist) {
    unlink($fntf);
  }
}

sub read_enc {
  my ($encf) = @_;
  local $_ = read_whole($encf);
  s/%.*//g; s/\s+/ /g; s/^.*?\[\s*// or return;
  s/\].*// or return; my @vec = split(m/ /, $_);
  (scalar(@vec) == 256) or return;
  return \@vec;
}
sub kpse {
  my ($f) = @_;
  local $_ = `kpsewhich $f`; chomp($_);
  ($_ ne '') or error("file not found on search path", $f);
  return $_;
}
sub read_whole {
  my ($f) = @_; local ($_, $/);
  open(my $h, '<', $f) or error("cannot open for read", $f);
  binmode($h); $_ = <$h>; close($h);
  return $_;
}
sub write_whole {
  my ($f, $d) = @_; local ($_, $/);
  open(my $h, '>', $f) or error("cannot open for write", $f);
  binmode($h); print $h ($d); close($h);
}
sub info {
  print STDERR (join(": ", $program, @_), "\n");
}
sub error {
  info(@_); exit(1);
}

main();
