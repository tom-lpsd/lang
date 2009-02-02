#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

typedef unsigned short int16;

typedef struct _bignum {
  int16 *values;
  int len;
} bignum;

bignum *alloc_bignum(int len)
{
  bignum *big;
  big = (bignum*)malloc(sizeof(bignum));
  big->values = (int16*)malloc(sizeof(int16)*len);
  big->len = len;
  return big;
}

void free_bignum(bignum *val)
{
  free(val->values);
  free(val);
}

bignum *expand_bignum(bignum *val, int n)
{
  int16 *buf, i, sign;

  buf = (int16*)malloc(sizeof(int16)*(n+val->len));

  if(val->values[val->len-1] & 0x8000) {
    sign = 0xffff;
  }
  else {
    sign = 0x0000;
  }

  for(i=0;i<val->len;++i){
    buf[i] = val->values[i];
  }
  for(;i<val->len+n;++i){
    buf[i] = sign;
  }

  free(val->values);
  val->values = buf;
  val->len += n;

  return val;
}

bignum *contract_bignum(bignum *val)
{
  int i,cnt=0;
  i = val->len;
  if(val->values[i-1] == (int16)0) {
    for(;i--;){
      if(val->values[i] == (int16)0) {
	++cnt;
      }
      else {
	break;
      }
    }
    val->len -= cnt;
    if(val->values[i] & 0x8000) {
      ++val->len;
    }
    if(val->len == 0) {
      ++val->len;
    }
    return val;
  }
  if(val->values[i-1] == 0xffff) {
    for(;i--;){
      if(val->values[i] == 0xffff) {
	++cnt;
      }
      else {
	break;
      }
    }
    val->len -= cnt;
    if(!(val->values[i] & 0x8000)) {
      ++val->len;
    }
    if(val->len == 0) {
      ++val->len;
    }
    return val;
  }
  return val;
}

bignum *parse_bignum(const char *numstr)
{
  char c;
  int i,j,len,carry,sign=0;
  unsigned num;
  bignum *val;

  len = strlen(numstr)/4+2;
  val = alloc_bignum(len);
  
  for(i=0;i<len;i++){
    val->values[i] = 0;
  }

  if(*numstr == '-') {
    numstr++;
    sign = 1;
  }

  j=1;
  while ((c = *numstr++)) {
    if (isdigit(c)) {
      c -= '0';
    }
    else {
      break;
    }
    i = 0;
    num = c;
    while(1) {
      while (i<j) {
	num += val->values[i]*10;
	val->values[i++] = (num & 0xffff);
	num = (num >> 16);
      }
      if (num) {
	j++;
	continue;
      }
      break;
    }
  }


  if(sign) {
    carry = 1;
    for(i=0;i<val->len;i++){
      val->values[i] = ~val->values[i];
      val->values[i] = val->values[i] + carry;
      carry = ((val->values[i] == 0 && carry) ? 1 : 0);
    }
  }

  contract_bignum(val);

  return val;
}

void completion_bignum(bignum *val)
{
  int i,carry;

  carry = 1;
  for(i=0;i<val->len;i++){
    val->values[i] = ~val->values[i];
    val->values[i] += carry;
    carry = ((val->values[i] == 0 && carry) ? 1 : 0);
  }

  for(i=val->len;i--;){
    if(val->values[i]==0){
      --val->len;
    }
    else {
      break;
    }
  }
}

void print_bignum(bignum *val)
{
  int i;
  i = val->len;

  if(val->values[i-1] == 0) {
    if(val->len == 1) {
      printf("0\n");
      return;
    }
    --i;
  }
  else if(val->values[i-1] & 0x8000) {
    printf("-");
    completion_bignum(val);
    i = val->len;
  }

  for(;i--;){
    if(i != (val->len-1)) {
      if(val->values[i]<4096) {
	printf("0");
      }
      if(val->values[i]<256) {
	printf("0");
      }
      if(val->values[i]<16) {
	printf("0");
      }
    }
    printf("%x", (int16)val->values[i]);
  }
  printf("\n");
}

void print_heximage_bignum(bignum *val)
{
  int i;
  i = val->len;

  for(;i--;){
    if(i != (val->len-1)) {
      if(val->values[i]<4096) {
	printf("0");
      }
      if(val->values[i]<256) {
	printf("0");
      }
      if(val->values[i]<16) {
	printf("0");
      }
    }
    printf("%x ", (int16)val->values[i]);
  }
  printf("\n");
}

bignum *add_bignum(bignum *lhs, bignum *rhs)
{
  int i, sign = 0, carry=0;
  bignum *big,*small,*val;

  if(lhs->len > rhs->len){
    big = lhs;
    small = rhs;
  }
  else {
    big = rhs;
    small = lhs;
  }
  
  val = alloc_bignum(big->len);

  if(small->values[small->len-1] & 0x8000) {
    sign = 0xffff;
  }

  for(i=0;i<small->len;++i) {
    carry += (int)big->values[i] + (int)small->values[i];
    val->values[i] = carry & 0xffff;
    carry >>= 16;
  }
  for(;i<big->len;++i) {
    carry += (int)big->values[i] + sign;
    val->values[i] = carry & 0xffff;
    carry >>= 16;
  }
  contract_bignum(val);

  return val;
}

bignum *sub_bignum(bignum *lhs, bignum *rhs)
{
  int i,  carry=0;
  bignum *big,*small,*val;

  if(lhs->len > rhs->len){
    big = lhs;
    small = rhs;
  }
  else {
    big = rhs;
    small = lhs;
  }
  
  val = alloc_bignum(big->len);

  expand_bignum(small, big->len - small->len);

  for(i=0;i<big->len;++i) {
    carry += (int)lhs->values[i] - (int)rhs->values[i];
    val->values[i] = carry & 0xffff;
    carry >>= 16;
  }

  if(carry && val->values[i-1] & 0x8000) {
    expand_bignum(val,1);
    val->values[val->len-1] = 0x0000;
  }

  contract_bignum(val);

  return val;
}

bignum *mul_bignum(bignum *lhs, bignum *rhs)
{
  int i=0, j=0, carry=0;
  bignum *big,*small,*val;
  val = alloc_bignum(lhs->len + rhs->len);

  for(i=0;i<val->len;++i){
    val->values[i] = 0;
  }

  if(lhs->len > rhs->len){
    big = lhs;
    small = rhs;
  }
  else {
    big = rhs;
    small = lhs;
  }

  carry = 0;
  for(i=0;i<small->len-1;++i){
    for(j=0;j<big->len-1;++j){
      carry = val->values[i+j] + carry +
	(unsigned)big->values[j] * (unsigned)small->values[i];
      val->values[i+j] = (carry & 0xffff);
      carry = (carry >> 16) & 0xffff;
    }
    carry = val->values[i+j] + carry +
      (int)big->values[j] * (unsigned)small->values[i];
    val->values[i+j] = (carry & 0xffff);
    carry = (carry >> 16) & 0xffff;
    if(carry) {
      val->values[i+j+1] += carry;
    }
    carry = 0;
  }
  for(j=0;j<big->len-1;++j){
    carry = val->values[i+j] + carry +
      (unsigned)big->values[j] * (int)small->values[i];
    val->values[i+j] = (carry & 0xffff);
    carry = (carry >> 16) & 0xffff;
  }
  carry = val->values[i+j] + carry + 
    (int)big->values[j] * (int)small->values[i];
  val->values[i+j] = (carry & 0xffff);
  carry = (carry >> 16) & 0xffff;
  
  if(carry) {
    val->values[val->len-1] += carry;
  }

  contract_bignum(val);

  return val;
}

int main(int argc, char *argv[])
{
  bignum *big1, *big2, *big3;

  if(argc < 3) {
    fprintf(stderr, "usage: %s num num", argv[0]);
  }

  big1 = parse_bignum(argv[1]);
  big2 = parse_bignum(argv[2]);
  big3 = mul_bignum(big1, big2);

  print_bignum(big3);

  free_bignum(big1);
  free_bignum(big2);
  free_bignum(big3);

  return 0;
}
