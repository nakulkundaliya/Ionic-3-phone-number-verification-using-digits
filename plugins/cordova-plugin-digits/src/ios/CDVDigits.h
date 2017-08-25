#import <Cordova/CDV.h>

@interface CDVDigits : CDVPlugin

- (void)authenticate:(CDVInvokedUrlCommand*)command;
- (void)logout:(CDVInvokedUrlCommand*)command;

@end
