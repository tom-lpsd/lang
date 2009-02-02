#ifndef _STATIC_CHECK_HPP
#define _STATIC_CHECK_HPP

template<bool> struct CompileTimeError;
template<> struct CompileTimeError<true> {};

#define STATIC_CHECK(expr, msg) \
    { CompileTimeError<((expr) != 0)> ERROR_##msg; (void)ERROR_##msg; } 


#endif // _STATIC_CHECK_HPP
