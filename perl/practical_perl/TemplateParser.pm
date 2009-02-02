package TemplateParser;
use strict;

sub parse {
    my ($pkg, $template_file, $inter_file) = @_;
    unless (open (T, $template_file)) {
	warn "$template_file : $@";
	return 1;
    }
    open (I, "> $inter_file") ||
	die "Error opening intermediate file $inter_file : $@";

    emit_opening_stmts($template_file);

    my $line;
    while (defined($line = <T>)) {
	if ($line !~ /^\s*\@/) {
	    emit_next($line);
	    next;
	}
	if ($line =~ /^\s*\@OPENFILE\s*(.*)\s*$/i) {
	    emit_open_file($1);
	}
	elsif ($line =~ /^\s*\@FOREACH\s*(\w*)\s*(.*)\s*/i) {
	    emit_loop_begin($1, $2);
	}
	elsif ($line =~ /^\s*\@END/i) {
	    emit_loop_end();
	}
	elsif ($line =~ /^\s*\@PERL(.*)/i) {
	    emit_perl("$1\n");
	}
    }
    emit_closing_stmts();

    close(I);
    return 0;
}

sub emit_opening_stmts {
    my $template_file = shift;
    emit("# Created automatically from $template_file");
emit(<<'_EOC_');
use Ast;
#use JeevesUtil;

$tmp_file = "jeeves.tmp";
sub open_file;
if (! (defined ($ROOT) && $ROOT)) {
    die "ROOT not defined \n";
}
$file = "> -";
open (F, $file) || die $@;
$code = "";
$ROOT->visit();
_EOC_
}

sub emit_open_file {
    my $file = shift;
    my $no_overwrite = ($file =~ s/-no_overwrite//gi) ? 1 : 0;
    my $append = ($file =~ s/-append//gi) ? 1 : 0;
    my $only_if_different = ($file =~ s/-only_if_different//gi) ? 1 : 0;
    $file =~ s/\s*//g;
emit(<<"_EOC_");
open_file(\"$file\", $no_overwrite, $only_if_different, $append);
_EOC_
}

sub emit_loop_begin {
    my $l_name = shift;
    my $condition = shift;
    my $l_name_i = $l_name . "_i";
emit(<<"_EOC_");
foreach \$$l_name_i (\@\${$l_name}) {
    \$$l_name_i->visit();
_EOC_
    if ($condition) {
	emit("next if (! ($condition));\n");
    }
}

sub emit_loop_end {
emit(<<"_EOC_");
Ast->bye();
}
_EOC_
}

sub emit {
    print I $_[0];
}
sub emit_perl {
    emit($_[0]);
}
sub emit_next {
    my $text = $_[0];
    chomp $text;

    $text =~ s/"/\\"/g;
    $text =~ s/'/\\'/g;

emit(<<"_EOC_");
output("$text\\n");
_EOC_
}

sub emit_closing_stmts {
emit(<<'_EOC_');
Ast::bye();
close(F);
unlink ($tmp_file);
sub open_file {
    my ($a_file, $a_nooverwrite, $a_only_if_different, $a_append) = @_;

    close(F);
#    if ($only_if_different) {
#	if (JeevesUtil::compare ($orig_file, $curr_file) != 0) {
#	    rename ($curr_file, $orig_file) ||
#		die "Error renaming $curr_file to $orig_file";
#	}
#    }

    $curr_file = $orig_file = $a_file;
    $only_if_different = ($a_only_if_different && (-f $curr_file)) ? 1 : 0;
    $mode = ($a_append) ? ">>" : ">";
    if ($only_if_different) {
	unlink ($tmp_file);
	$curr_file = $tmp_file;
    }
    if (! $no_overwrite) {
	open (F, "$mode $curr_file") ||
	    die "could not open $curr_file";
    }
}

sub output {
    print F @_ if (! $no_overwrite);
}
1;
_EOC_
}
1;

