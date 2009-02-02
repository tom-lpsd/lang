#include <cmath>
#include <iostream>
using namespace std;

/****************************************************************************
 * DExpr is a wrapper class which contains a more interesting expression type,
 * such as DExprIdentity, DExprLiteral, or DBinExprOp.                      *
 ****************************************************************************/
template<typename A>
class DExpr {
  A a_;
public:
  DExpr(const A& x = A()) : a_(x) {}
  double operator()(double x) const { 
    return a_(x); 
  }
};

/****************************************************************************
 * DExprIdentity is a placeholder for the variable in the expression.       *
 ****************************************************************************/

class DExprIdentity {
public:
  double operator()(double x) const { 
    return x; 
  }
};

// Make a convenient typedef for the placeholder type.
typedef DExpr<DExprIdentity> DPlaceholder;


/****************************************************************************
 * DExprLiteral represents a double literal which appears in the expression.*
 ****************************************************************************/

class DExprLiteral {
  double value_;
public:
  DExprLiteral(double value) : value_(value) {} 
  double operator()(double x) const { 
    return value_; 
  }
};

/****************************************************************************
 * APPLICATIVE TEMPLATE CLASSES                                             *
 ****************************************************************************/

// DApAdd -- add two doubles
class DApAdd {
public:
  static double apply(double a, double b){ 
    return a+b; 
  }
};

// DApSub -- subtruct two doubles
class DApSub {
public:
  static double apply(double a, double b){ 
    return a-b; 
  }
};

// DApDivide -- divide two doubles
class DApDivide {
public:
  static double apply(double a, double b){ 
    return a/b; 
  }
};

// DApMultiply -- multiply two doubles
class DApMultiply {
public:
  static double apply(double a, double b){ 
    return a*b; 
  }
};

// DApSine -- sine value
class DApSine {
public:
  static double apply(double a){
    return std::sin(a); 
  }
};

// DApCosine -- cosine value
class DApCosine {
public:
  static double apply(double a){
    return std::cos(a); 
  }
};

/****************************************************************************
 * DBinExprOp represents a binary operation on two expressions.             *
 * A and B are the two expressions being combined, and Op is an applicative *
 * template representing the operation.                                     *
 ****************************************************************************/

template<typename A, typename B, typename Op>
class DBinExprOp {
  A a_;
  B b_;
public:
  DBinExprOp(const A& a, const B& b)
    : a_(a), b_(b) {}
  double operator()(double x) const { 
    return Op::apply(a_(x), b_(x)); 
  }
};

template<typename A, typename Op>
class DUniExprOp {
  A a_;
public:
  DUniExprOp(const A& a) : a_(a) {}
  double operator()(double x) const { 
    return Op::apply(a_(x));
  }
};

/****************************************************************************
 * OPERATORS                                                                *
 ****************************************************************************/

// operator+(double, DExpr)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApAdd> >
operator+(double x, const DExpr<A>& a)
{
  typedef DBinExprOp<DExprLiteral, DExpr<A>, DApAdd> ExprT;
  return DExpr<ExprT>(ExprT(DExprLiteral(x),a));
}

// operator+(DExpr, double)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApAdd> >
operator+(const DExpr<A>& a, double x)
{
  return x+a;
}

// operator-(double, DExpr)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApSub> >
operator-(double x, const DExpr<A>& a)
{
  typedef DBinExprOp<DExprLiteral, DExpr<A>, DApSub> ExprT;
  return DExpr<ExprT>(ExprT(DExprLiteral(x),a));
}

// operator-(DExpr, double)
template<class A>
DExpr<DBinExprOp<DExpr<A>, DExprLiteral, DApSub> >
operator-(const DExpr<A>& a, double x)
{
  typedef DBinExprOp<DExpr<A>, DExprLiteral, DApSub> ExprT;
  return DExpr<ExprT>(ExprT(a, DExprLiteral(x)));
}

// operator*(double, DExpr)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApMultiply> >
operator*(double x, const DExpr<A>& a)
{
  typedef DBinExprOp<DExprLiteral, DExpr<A>, DApMultiply> ExprT;
  return DExpr<ExprT>(ExprT(DExprLiteral(x),a));
}

// operator*(DExpr, double)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApMultiply> >
operator*(const DExpr<A>& a, double x)
{
  return x*a;
}

// operator/(double, DExpr)
template<class A>
DExpr<DBinExprOp<DExprLiteral, DExpr<A>, DApDivide> >
operator/(double x, const DExpr<A>& a)
{
  typedef DBinExprOp<DExprLiteral, DExpr<A>, DApDivide> ExprT;
  return DExpr<ExprT>(ExprT(DExprLiteral(x),a));
}

// operator/(DExpr, double)
template<class A>
DExpr<DBinExprOp<DExpr<A>, DExprLiteral, DApDivide> >
operator/(const DExpr<A>& a, double x)
{
  typedef DBinExprOp<DExpr<A>, DExprLiteral, DApDivide> ExprT;
  return DExpr<ExprT>(ExprT(a, DExprLiteral(x)));
}

// operator+(DExpr, DExpr)
template<class A, class B>
DExpr<DBinExprOp<DExpr<A>, DExpr<B>, DApAdd> >
operator+(const DExpr<A>& a, const DExpr<B>& b)
{
  typedef DBinExprOp<DExpr<A>, DExpr<B>, DApAdd> ExprT;
  return DExpr<ExprT>(ExprT(a,b));
}

// operator-(DExpr, DExpr)
template<class A, class B>
DExpr<DBinExprOp<DExpr<A>, DExpr<B>, DApSub> >
operator-(const DExpr<A>& a, const DExpr<B>& b)
{
  typedef DBinExprOp<DExpr<A>, DExpr<B>, DApSub> ExprT;
  return DExpr<ExprT>(ExprT(a,b));
}

// operator*(DExpr, DExpr)
template<class A, class B>
DExpr<DBinExprOp<DExpr<A>, DExpr<B>, DApMultiply> >
operator*(const DExpr<A>& a, const DExpr<B>& b)
{
  typedef DBinExprOp<DExpr<A>, DExpr<B>, DApMultiply> ExprT;
  return DExpr<ExprT>(ExprT(a,b));
}

// operator/(DExpr, DExpr)
template<class A, class B>
DExpr<DBinExprOp<DExpr<A>, DExpr<B>, DApDivide> >
operator/(const DExpr<A>& a, const DExpr<B>& b)
{
  typedef DBinExprOp<DExpr<A>, DExpr<B>, DApDivide> ExprT;
  return DExpr<ExprT>(ExprT(a,b));
}

// sin(DExpr)
template<typename A>
DExpr<DUniExprOp<DExpr<A>, DApSine> >
sin(const DExpr<A>& a)
{
  typedef DUniExprOp<DExpr<A>, DApSine> ExprT;
  return DExpr<ExprT>(ExprT(a));
}

// cos(DExpr)
template<typename A>
DExpr<DUniExprOp<DExpr<A>, DApCosine> >
cos(const DExpr<A>& a)
{
  typedef DUniExprOp<DExpr<A>, DApCosine> ExprT;
  return DExpr<ExprT>(ExprT(a));
}

template<class Expr>
void evaluate(DExpr<Expr> expr, double start, double end)
{
  const double step = 0.01;
  for (double i=start; i < end; i += step){
    cout << expr(i) << endl;
  }
}
          
int main()
{
  DPlaceholder x;         // Placeholder
  evaluate(sin(x)*cos(x*2.0+1.0), -6.28, 6.28);
  return 0;
}
