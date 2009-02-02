sub search_files {
  my ($pattern, $filepattern) = @_;
  local (@ARGV) = ("ex.c"); #glob($filepattern);
  return unless @ARGV;
  while(<>) {
    if (/$pattern/o) {
      print "$ARGV\[$.\]: $_";
    }
  }
}
