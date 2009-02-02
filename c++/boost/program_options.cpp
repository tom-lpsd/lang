#include <iostream>
#include <string>
#include <boost/program_options.hpp>
using namespace std;
namespace po = boost::program_options;

int main(int argc, char *argv[])
{
    po::options_description desc("Allowed Options");
    po::positional_options_description p;

    desc.add_options()
	("help,h", "produce help message")
	("input,f", po::value<string>()->default_value("m.dat"), "input matrix filename");
    p.add("input", -1);

    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv).
	      options(desc).positional(p).run(), vm);
    po::notify(vm); 

    if (vm.count("input")) {
	cout << vm["input"].as<string>() << endl;
    }

    return 0;
}
