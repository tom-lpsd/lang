#include <cmath>
#include <cstdlib>
#include <iostream>
#include <algorithm>
#include <limits>
using namespace std;

struct Coord {
  int x,y,index;
  Coord() : x(0),y(0),index(0){}
  bool operator < (const Coord &x) const{
    return ((this->y * this->y + this->x * this->x ) < (x.x * x.x + x.y * x.y));
  }
};

inline double my_distance(const Coord &r1, const Coord &r2)
{
  return sqrt((r1.x-r2.x)*(r1.x-r2.x)+(r1.y-r2.y)*(r1.y-r2.y));
}

template<typename Iterator>
inline double sum_distance(Iterator s, Iterator e){
  double sum = 0.0;
  for(Iterator i=s;i!=(e-1);i++){
    sum += my_distance(*i,*(i+1));
  }
  sum += my_distance(*s,*(e-1));
  return sum;
}

int main()
{
#ifdef L
  const static int num = 16384;
#else
  const static int num = 128;
#endif
  Coord data[num],ans[num],cons[num];

  for(int i=0;i<num;i++){
    cin >> data[i].x >> data[i].y;
    data[i].index = i;
  }

  copy(&data[0],&data[num],&cons[0]);

  //  sort(&data[0],&data[num]);
    
  double min_distance = numeric_limits<double>::max();
  for(int it=0;it<128;it++){
    copy(&cons[0],&cons[num],&data[0]);
  
    swap(data[0],data[it]);
    for(int i=1;i<num+1;i++){
      double min = numeric_limits<double>::max();
      int index = i;
      for(int j=i;j<num;j++){
	double buf = my_distance(data[i-1],data[j]);
	if(min > buf){
	  min = buf;
	  index = j;
	}
      }
      swap(data[i],data[index]);
    }
    double buf = sum_distance(&data[0],&data[num]);
    if(min_distance >buf){
      min_distance = buf;
      copy(&data[0],&data[num],&ans[0]);
    } 
  }

  srandom(time(0));
  for(int i=0;i<100000;i++){
    int r1 = static_cast<int>(double(random())/RAND_MAX*num);
    int r2 = static_cast<int>(double(random())/RAND_MAX*num);
    swap(ans[r1],ans[r2]);
    double buf = sum_distance(&ans[0],&ans[num]);
    if(min_distance > buf){
      min_distance = buf;
    }
    else{
      swap(ans[r1],ans[r2]);
    }
  }

  for(int i=0;i<num;i++){
    cout << ans[i].x << " " << ans[i].y << " " << ans[i].index << '\n';
  }
  cout << ans[0].x << " " << ans[0].y << " " << ans[0].index << endl;

  cerr << min_distance << endl;

  return 0;
}
