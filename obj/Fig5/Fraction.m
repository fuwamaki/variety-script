#import "Fraction.h"
#import <Foundation/NSString.h>
#import <stdlib.h>

@implementation Fraction

static int gcd(int a, int b)
{
	if (a < b)
		return gcd(b, a);
	if (b == 0)
		return a;
	return gcd(b, a % b);
}

- (void)reduce
{
	int d;

	if (num == 0) {
		sgn = 1;
		den = 1;
		return;
	}

	if (den == 0) {
		num = 1;
		return;
	}

	if ((d = gcd(num, den)) == 1)
		return;

	num /= d;
	den /= d;
}

+ (id)fractionWithNumerator:(int)n denominator:(int)d
{
	id f = [[self alloc] initWithNumerator:n denominator:d];
	return [f autorelease];
}

#define SIGN(a) (((a) >= 0) ? 1 : (-1) )

- (id)initWithNumerator:(int)n denominator:(int)d
{
	if ((self = [super init]) != nil) {
		sgn = SIGN(n) * SIGN(d);
		num = abs(n);
		den = abs(d);
		[self reduce];
	}
	return self;
}

- (Fraction *)add:(Fraction *)obj
{
	int n, d;
	if (den == obj->den) {
		n = sgn * num + obj->sgn * obj->num;
		d = den;
	} else {
		n = sgn * num * obj->den + obj->sgn * obj->num * den;
		d = den * obj->den;
	}
	return [Fraction fractionWithNumerator:n denominator:d];
}

- (Fraction *)sub:(Fraction *)obj
{
	Fraction *tmp;
	int n = -1 * obj->sgn * obj->num;
	tmp = [Fraction fractionWithNumerator:n denominator:obj->den];
	return [self add: tmp];
}

- (Fraction *)mul:(Fraction *)obj
{
	int n = sgn * obj->sgn * num * obj->num;
	int d = den * obj->den;
	return [Fraction fractionWithNumerator:n denominator:d];
}

- (Fraction *)div:(Fraction *)obj
{
	int n = sgn * obj->sgn * num * obj->den;
	int d = den * obj->num;
	return [Fraction fractionWithNumerator:n denominator:d];
}

- (NSString *)description
{
	int n = (sgn >= 0) ? num : -num;
	return (den == 1)
		? [NSString stringWithFormat:@"%d", n]
		: [NSString stringWithFormat:@"%d/%d", n, den];
}

@end

