#include <iostream>
#include <memory>

// テスト用のクラス
class CSample
{
public:
  CSample(int num){ m_num = num; std::cout << "コンストラクタ" << std::endl;  }
  ~CSample(){ std::cout << "デストラクタ" << std::endl; }

  int Get() const { return m_num; }
private:
  int m_num;
};

// プロトタイプ宣言
std::auto_ptr<CSample> Create(int num);


int main()
{
  std::auto_ptr<CSample> p;
  p = Create( 100 );	// インスタンスを作ってもらう
  std::cout << "Create()から戻った" << std::endl;

  std::cout << p->Get() << std::endl;	// auto_ptrからメンバをアクセス
  return 0;
}

// 工場
std::auto_ptr<CSample> Create(int num)
{
  std::cout << "Create()を呼び出した" << std::endl;

  std::auto_ptr<CSample> p( new CSample( num ) );	// インスタンスを生成
  return p;	// 生成したインスタンスを返す
}
