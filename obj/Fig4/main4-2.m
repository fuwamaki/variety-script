#import <Foundation/NSObject.h>
#import <stdio.h>

@interface A: NSObject
- (void)whoAreYou;
@end

@implementation A
- (void)whoAreYou
{
	printf("I'm A\n");
}
@end

@interface B: A
- (void)whoAreYou;
- (void)sayHello;
@end

@implementation B
- (void)whoAreYou
{
	printf("I'm B\n");
}
- (void)sayHello
{
	printf("Hello\n");
}
@end

@interface C: NSObject
- (void)printName;
@end

@implementation C
- (void)printName
{
	printf("I'm C\n");
}
@end

int main(void)
{
	A *a, *b;
	id c;

	a = [[A alloc] init];
	b = [[B alloc] init];
	c = [[C alloc] init];
	[a whoAreYou];
	[b whoAreYou];
	[c printName];
	return 0;
}

