package Drive;
use Apache2::Const ();
use Apache2::RequestRec ();
use Apache2::RequestUtil ();

sub handler :method {
    my ($class, $r) = @_;
    $r->content_type("text/html");
    print "<html><body>OK</body></html>";
    return Apache2::Const::OK;
}

1;
