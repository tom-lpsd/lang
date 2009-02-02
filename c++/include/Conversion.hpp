#ifndef _CONVERSION_HPP
#define _CONVERSION_HPP
#define SUPERSUBCLASS(T,U) \
    (Conversion<const U*, const T*>::exists && \
    !Conversion<const T*, void *>::sameType)
#define SUPERSUBCLASS_STRICT(T,U) \
    (SUPERSUBCLASS(T,U) && \
    !Conversion<const *T, const *U>::sameType)

template<class T, class U>
class Conversion {
  typedef char Small;
  class Big { char dummy[2]; };
  static Small Test(U);
  static Big Test(...);
  static T MakeT();
public:
  static const bool exists = (sizeof(Test(MakeT())) == sizeof(Small));
  static const bool sameType = false;
};

template<class T>
class Conversion<T,T> {
public:
  static const bool exists = true;
  static const bool sameType = true;
};

#endif // _CONVERSION_HPP
