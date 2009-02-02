#include <iostream>
#include <string>
#include <vector>
#include <boost/program_options.hpp>
using namespace std;
using namespace boost::program_options;

int main(int argc, char *argv[])
{
  int opt;
  options_description desc("Allowed options");
  desc.add_options()
    ("help", "produce help message")
    ("optimization", value<int>(&opt)->default_value(10), 
     "optimization level")
    ("include-path,I",value<string>(),
     "include path")
    ("input-file", value<string>(), "input-file");

  variables_map vm;
  store(parse_command_line(argc,argv,desc),vm);
  notify(vm);

  positional_options_description p;
  p.add("input-file", -1);

  store(command_line_parser(argc, argv).
          options(desc).positional(p).run(), vm);
  notify(vm);

  if(vm.count("help")){
    cout << desc;
    return 1;
  }
    
  if(vm.count("include-path")){
    cout << "Include paths are: "
	 << vm["include-path"].as<string>() << "\n";
  }

  if(vm.count("input-file")){
    cout << "Input files are: "
	 << vm["input-file"].as<string>() << "\n";
  }

  cout << "optimization level " << opt << ".\n";

  return 0;
}
