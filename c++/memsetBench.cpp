#include <algorithm>
#include <cstring>
#include "Timer.hpp"
using namespace std;
using namespace utility;

int main()
{
    const int num = 40000;
    const int freq = 500000;

    char ch[num];
    int in[num];

    {
	Timer t("char(fill)");
	for (int i=0;i<freq;++i) {
	    std::fill(ch, ch+num, '\0');
	}
    }
    {
	Timer t("char(memset)");
	for (int i=0;i<freq;++i) {
	    std::memset(ch, 0, sizeof(char)*num);
	}
    }
    {
	Timer t("int(fill)");
	for (int i=0;i<freq;++i) {
	    std::fill(in, in+num, 0);
	}
    }
    {
	Timer t("int(memset)");
	for (int i=0;i<freq;++i) {
	    std::memset(in, 0, sizeof(int)*num);
	}
    }

    return 0;
}
