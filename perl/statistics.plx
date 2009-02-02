use Sys::Statistics::Linux;
use Data::Dumper;

my $lxs = Sys::Statistics::Linux->new(
    SysInfo   => 1,
    CpuStats  => 1,
    ProcStats => 1,
    MemStats  => 1,
    PgSwStats => 1,
    NetStats  => 1,
    SockStats => 1,
    DiskStats => 1,
    DiskUsage => 1,
    LoadAVG   => 1,
    FileStats => 1,
    Processes => 1,
);

sleep 1;

my $stat = $lxs->get;
print Dumper($stat), "\n";
