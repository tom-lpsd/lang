/*****************************************************************************
 * Simple vector class implementation using expression templates             *
 * Author: Todd Veldhuizen        (tveldhui@seurat.uwaterloo.ca)             *
 *                                                                           *
 * This program may be redistributed in an unmodified form.  It may not be   *
 * sold or used in a commercial product.                                     *
 *                                                                           *
 * For more information on these template techniques, please see the         *
 * Blitz++ Numerical Library Project, at URL http://monet.uwaterloo.ca/blitz *
 *****************************************************************************/

/*****************************************************************************
 * dvec.h      Use with dvec.cpp                                             *
 *                                                                           *
 * Code for generating optimized vector expressions, using the expression    *
 * templates technique.  For simplicity, this implementation is only for     *
 * double vectors and doesn't perform bounds checking, but a general version *
 * isn't difficult.                                                          *
 *                                                                           *
 * Performance tuning:                                                       *
 * - Use EXPRVEC_USE_TEMPORARY_EXPRESSION for segmented architectures        *
 *   (this puts a temporary copy of the expression on the stack, so that     *
 *   all iterators are in the same segment)                                  *
 * - Use EXPRVEC_USE_INDIRECTION if your platform is faster at               *
 *      for (int i=len; i--;)                                                *
 *          y[i] = a[i]+b[i]+c[i]+d[i];                                      *
 *   than                                                                    *
 *      do {                                                                 *
 *          *yp = *ap + *bp + *cp + *dp;                                     *
 *          ++ap; ++bp; ++cp; ++dp;                                          *
 *      } while (++yp != yend);                                              *
 *****************************************************************************/

#define EXPRVEC_USE_TEMPORARY_EXPRESSION
#define EXPRVEC_USE_INDIRECTION

#include <math.h>

/****************************************************************************
 * DVecAssignable provides a virtual function 'assign' which is             *
 * used to implement DVec::operator=(expr)                                  *
 ****************************************************************************/

class DVec;

class DVecAssignable {
public:
  virtual void assign(DVec&) const = 0;
  virtual ~DVecAssignable() {}
};

/****************************************************************************
 * DVec -- a simple vector class.                                           *
 *    - has STL standard begin() and end()                                  *
 *    - overloaded operator=(Expr)                                          *
 ****************************************************************************/

class DVec {

private:
    double* data_;
    int length_;

public:      
    typedef double* iterT;
    typedef double  elementT;

    DVec(int n)
        : length_(n)
    { data_ = new double[n]; }

    ~DVec()
    { delete [] data_; }

    double& operator[](int i)
    { return data_[i]; }

    iterT begin() const
    { return data_; }

    iterT end() const
    { return data_ + length_; }

    int length() const
    { return length_; }

    // A DVecAssignable object represents an inlined
    // vector expression.
    DVec& operator=(const DVecAssignable& x)
    { x.assign(*this); return *this; }
};

/****************************************************************************
 * Binary applicative templates -- omit these in printing (they've already  *
 * been seen in the first example)                                          *
 ****************************************************************************/

// DApAdd -- add two doubles
class DApAdd {

public:
    DApAdd() { }

    static inline double apply(double a, double b)
    { return a+b; }
};

// DApDivide -- divide two doubles
class DApDivide {
public:
    DApDivide() { }

    static inline double apply(double a, double b)
    { return a/b; }
};

class DApSubtract {
public:
    DApSubtract() { }

    static inline double apply(double a, double b)
    { return a-b; }
};

class DApMultiply {
public:
    DApMultiply() { }

    static inline double apply(double a, double b)
    { return a*b; }
};

/****************************************************************************
 * assignResult() -- store an expression result into a vector.  This        *
 * is the function that has the vector expression inlined into it.          *
 * Don't be scared by all the #ifdef's -- they're just for performance      *
 * tuning.                                                                  *
 ****************************************************************************/

template<class Iter>
void assignResult(DVec& a, const Iter& result)
{
#ifdef EXPRVEC_USE_TEMPORARY_EXPRESSION
    // Make a temporary copy of the iterator.  This is faster on segmented
    // architectures, since all the iterators are in the same segment.
    Iter result2 = result;
#else
    // Otherwise, cast away const (eek!).  No harmful side effects.
    Iter& result2 = (Iter&)result;
#endif

#ifdef EXPRVEC_USE_INDIRECTION
    double* iter = a.begin();

    for (register int i = a.length(); i--;)
        iter[i] = result2[i];   // Inlined expression
#else
    double* iter = a.begin();
    double* end  = a.end();

    do {
        *iter = *result2;       // Inlined expression
        ++result2;
    } while (++iter != end);
#endif
}

/****************************************************************************
 * DVExpr -- a vector expression iterator                                   *
 ****************************************************************************/
template<class A>
class DVExpr : public DVecAssignable {

private:
    A iter_;

public:
    DVExpr(const A& a)
        : iter_(a)
    { }

    double operator*() const
    { return *iter_; }

    double operator[](int i) const
    { return iter_[i]; }

    void operator++()
    { ++iter_; }

    // Virtual function from DVecAssignable.  Called by
    // DVec::operator=(DVecAssignable&).
    virtual void assign(DVec& x) const
    { assignResult(x, *this); }
};

/****************************************************************************
 * A DVBinExprOp represents an operation on two dereferenced iterators (A,B).
 * It can be thought of as an "applicative iterator", combining the         *
 * notion of an STL applicative template, and an iterator.                  *
 ****************************************************************************/
template<class A, class B, class Op>
class DVBinExprOp {

private:
    A iter1_;
    B iter2_;

public:
    DVBinExprOp(const A& a, const B& b)
        : iter1_(a), iter2_(b)
    { }

    void operator++()
    { ++iter1_; ++iter2_; }

    double operator*() const
    { return Op::apply(*iter1_,*iter2_); }

    double operator[](int i) const
    { return Op::apply(iter1_[i], iter2_[i]); }
};

/*
 * ADDITION OPERATORS
 */

DVExpr<DVBinExprOp<double*,double*,DApAdd> >
operator+(const DVec& a, const DVec& b)
{
    typedef DVBinExprOp<double*,double*,DApAdd> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<DVExpr<A>,double*,DApAdd> >
operator+(const DVExpr<A>& a, const DVec& b)
{
    typedef DVBinExprOp<DVExpr<A>,double*,DApAdd> ExprT;
    return DVExpr<ExprT>(ExprT(a,b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<double*,DVExpr<A>,DApAdd> >
operator+(const DVec& a, const DVExpr<A>& b)
{
    typedef DVBinExprOp<double*,DVExpr<A>,DApAdd> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b));
}

template<class A, class B>
DVExpr<DVBinExprOp<DVExpr<A>,DVExpr<B>,DApAdd> >
operator+(const DVExpr<A>& a, const DVExpr<B>& b)
{
    typedef DVBinExprOp<DVExpr<A>,DVExpr<B>,DApAdd> ExprT;
    return DVExpr<ExprT>(ExprT(a,b));
}

/*
 * SUBTRACTION OPERATORS
 */

DVExpr<DVBinExprOp<double*,double*,DApSubtract> >
operator-(const DVec& a, const DVec& b)
{
    typedef DVBinExprOp<double*,double*,DApSubtract> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<DVExpr<A>,double*,DApSubtract> >
operator-(const DVExpr<A>& a, const DVec& b)
{
    typedef DVBinExprOp<DVExpr<A>,double*,DApSubtract> ExprT;
    return DVExpr<ExprT>(ExprT(a,b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<double*,DVExpr<A>,DApSubtract> >
operator-(const DVec& a, const DVExpr<A>& b)
{
    typedef DVBinExprOp<double*,DVExpr<A>,DApSubtract> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b));
}

template<class A, class B>
DVExpr<DVBinExprOp<DVExpr<A>,DVExpr<B>,DApSubtract> >
operator-(const DVExpr<A>& a, const DVExpr<B>& b)
{
    typedef DVBinExprOp<DVExpr<A>,DVExpr<B>,DApSubtract> ExprT;
    return DVExpr<ExprT>(ExprT(a,b));
}


/*
 * DIVISION OPERATORS
 */

DVExpr<DVBinExprOp<double*,double*,DApDivide> >
operator/(const DVec& a, const DVec& b)
{
    typedef DVBinExprOp<double*,double*,DApDivide> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<DVExpr<A>,double*,DApDivide> >
operator/(const DVExpr<A>& a, const DVec& b)
{
    typedef DVBinExprOp<DVExpr<A>,double*,DApDivide> ExprT;
    return DVExpr<ExprT>(ExprT(a,b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<double*,DVExpr<A>,DApDivide> >
operator/(const DVec& a, const DVExpr<A>& b)
{
    typedef DVBinExprOp<double*,DVExpr<A>,DApDivide> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b));
}

template<class A, class B>
DVExpr<DVBinExprOp<DVExpr<A>,DVExpr<B>,DApDivide> >
operator/(const DVExpr<A>& a, const DVExpr<B>& b)
{
    typedef DVBinExprOp<DVExpr<A>,DVExpr<B>,DApDivide> ExprT;
    return DVExpr<ExprT>(ExprT(a,b));
}


/*
 * MULTIPLICATION OPERATORS
 */

DVExpr<DVBinExprOp<double*,double*,DApMultiply> >
operator*(const DVec& a, const DVec& b)
{
    typedef DVBinExprOp<double*,double*,DApMultiply> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<DVExpr<A>,double*,DApMultiply> >
operator*(const DVExpr<A>& a, const DVec& b)
{
    typedef DVBinExprOp<DVExpr<A>,double*,DApMultiply> ExprT;
    return DVExpr<ExprT>(ExprT(a,b.begin()));
}

template<class A>
DVExpr<DVBinExprOp<double*,DVExpr<A>,DApMultiply> >
operator*(const DVec& a, const DVExpr<A>& b)
{
    typedef DVBinExprOp<double*,DVExpr<A>,DApMultiply> ExprT;
    return DVExpr<ExprT>(ExprT(a.begin(),b));
}

template<class A, class B>
DVExpr<DVBinExprOp<DVExpr<A>,DVExpr<B>,DApMultiply> >
operator*(const DVExpr<A>& a, const DVExpr<B>& b)
{
    typedef DVBinExprOp<DVExpr<A>,DVExpr<B>,DApMultiply> ExprT;
    return DVExpr<ExprT>(ExprT(a,b));
}

