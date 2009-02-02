#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

int main (void)
{
    NSAutoreleasePool *pool;
  
    pool = [NSAutoreleasePool new];
  
    [NSApplication sharedApplication];
  
    NSRunAlertPanel (@"Test", @"Hello from the GNUstep AppKit", 
		     nil, nil, nil);
    
    return 0;
}
