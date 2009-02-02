#ifndef _BENCHMARKER_HPP
#define _BENCHMARKER_HPP
#include <ctime>
#include <iostream>

/**
 *  @brief プログラムの実行時間を計測するためのクラス
 *         elapsedTime()を呼ぶと，コンストラクタを
 *         呼んだ時点からの経過時間がmsec単位で返る．
 */
class Benchmarker {
  std::clock_t start_;
  const char *message_;
public:
  explicit
  Benchmarker(const char *mes=0) : start_(std::clock()),message_(mes) {}

  /**
   *  @brief コンストラクタまたはreset()メソッドを呼んだ
   *         時点からの経過時間をmsec単位で返す．
   */
  double elapsedTime() {
    return (clock()-start_)*1000.0/CLOCKS_PER_SEC;
  }

  /**
   *  @brief 経過時間をリセットする．
   */
  void reset() {
    start_ = std::clock();
  }

  ~Benchmarker(){
    if(message_){
      std::cerr << message_ << " "
		<< elapsedTime() << "[msec]" << std::endl;
    }
  }
};

#endif // _BENCHMARKER_HPP
