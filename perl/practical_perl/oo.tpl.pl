# Created automatically from oo.tpluse Ast;
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
foreach $class_list_i (@${class_list}) {
    $class_list_i->visit();
open_file("${class_name}.h", 0, 0, 0);
output("#ifndef _${class_name}_h_\n");
output("#define _${class_name}_h_\n");
output("#include <Object.h>\n");
 $user = $ENV{"USER"};
output("// File : \'${class_name}.h\'\n");
output("// User : \"$user\"\n");
output("class $class_name : public Object {\n");
foreach $attr_list_i (@${attr_list}) {
    $attr_list_i->visit();
output("    $attr_type $attr_name;\n");
Ast->bye();
}
output("    $class_name();\n");
output("public:\n");
output("    $class_name *Create();\n");
output("    ~$class_name();\n");
output("\n");
foreach $attr_list_i (@${attr_list}) {
    $attr_list_i->visit();
output("    $attr_type get_${attr_name}();\n");
output("    void set_${attr_name}($attr_type);\n");
Ast->bye();
}
output("}\n");
output("#endif\n");
Ast->bye();
}
output("\n");
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
