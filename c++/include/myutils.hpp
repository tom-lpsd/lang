#ifndef _MYUTILS_HPP
#define _MYUTILS_HPP

template<bool flag, typename T, typename U>
struct Select {
  typedef T Result;
};

template<typename T, typename U>
struct Select<false,T,U> {
  typedef U Result;
};

#endif // _MYUTILS_HPP
