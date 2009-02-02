#include <iostream>
#include <stdexcept>
using namespace std;

template<class T>
class SingletonHolder {
public:
  static T &Instance(){
    if(!pInstance_){
      if(destroyed_){
	OnDeadReference();
      }
      else{
	Create();
      }
    }
    return *pInstance_;
  }

private:
  static void Create(){
    static T theInstance;
    pInstance_ = &theInstance;
  }

  static void OnDeadReference(){
    throw std::runtime_error("Dead Reference Detected");
  }

  virtual ~SingletonHolder(){
    pInstance_ = 0;
    destroyed_ = true;
  }

  static T *pInstance_;
  static bool destroyed_;
};

class Log {
  int *x;
  Log() : x(new int(100)) {}
  Log(const Log&);
  Log &operator=(const Log&);
  friend class SingletonHolder<Log>;
public:
  void output(runtime_error &e){
    cerr << e.what() << endl;
  }
  void getValue() {
    cerr << *x << endl;
  }
  ~Log(){
    cerr << "Log destructted!" << endl;
    delete x;
    x = 0;
  }
};

class Display {
public:
  Display() try {
      throw runtime_error("Display constructor error");
  }
  catch(runtime_error &e){
    Log &lg = SingletonHolder<Log>::Instance();
    lg.output(e);
    exit(1);
  }
};

class Keyboard {
public:
  ~Keyboard() try {
    throw runtime_error("Keyboard destructor error");
  }
  catch(runtime_error &e){
    Log &lg = SingletonHolder<Log>::Instance();
    lg.output(e);
    lg.getValue();
    exit(2);
  }
};

template<class T> T *SingletonHolder<T>::pInstance_ = 0;
template<class T> bool SingletonHolder<T>::destroyed_ = false;

int main()
{
  Keyboard &kbd = SingletonHolder<Keyboard>::Instance();
  Display &dis = SingletonHolder<Display>::Instance();

  return 0;
}
