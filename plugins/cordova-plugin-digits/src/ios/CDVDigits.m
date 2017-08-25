#import "CDVDigits.h"

#import <Cordova/CDV.h>
#import <Crashlytics/Crashlytics.h>
#import <DigitsKit/DigitsKit.h>
#import <Fabric/Fabric.h>

@implementation CDVDigits

+ (UIColor *)colorFromHexString:(NSString *)hexString {
  unsigned rgbValue = 0;

  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1];
  [scanner scanHexInt:&rgbValue];

  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                         green:((rgbValue & 0xFF00) >> 8) / 255.0
                          blue:(rgbValue & 0xFF) / 255.0
                         alpha:1.0];
}

- (void)pluginInitialize {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void)finishLaunching:(NSNotification *)notification {
  [Fabric with:@[[Crashlytics class], [Digits class]]];
}

- (void)authenticate:(CDVInvokedUrlCommand *)command {
  NSDictionary *options = [command argumentAtIndex:0];

  Digits *digits = [Digits sharedInstance];

  DGTAppearance *appearance;
  DGTAuthenticationConfiguration *configuration;

  appearance = [[DGTAppearance alloc] init];
  configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
  configuration.appearance = appearance;

  if ([options objectForKey:@"backgroundColor"]) { appearance.accentColor = [CDVDigits colorFromHexString:[options objectForKey:@"backgroundColor"]]; }
  if ([options objectForKey:@"accentColor"]) { appearance.accentColor = [CDVDigits colorFromHexString:[options objectForKey:@"accentColor"]]; }

  [[Digits sharedInstance] authenticateWithViewController:nil
                                            configuration:configuration
                                               completion:^(DGTSession *session, NSError *error) {
    CDVPluginResult* pluginResult = nil;

    if (session) {
      //DGTOAuthSigning *oauthSigning = [[DGTOAuthSigning alloc] initWithAuthConfig:digits.authConfig authSession:digits.session];
      // NSDictionary *authHeaders = [oauthSigning OAuthEchoHeadersToVerifyCredentials];
      NSMutableDictionary *authHeaders = [[NSMutableDictionary alloc] init];
      [authHeaders setValue:session.phoneNumber forKey: @"phoneNumber"];
      NSError *error;
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:authHeaders
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
      NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                       messageAsString:jsonString];
    } else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                       messageAsString:[error localizedDescription]];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }];
}

- (void)logout:(CDVInvokedUrlCommand *)command {
  Digits *digits = [Digits sharedInstance];
  [digits logOut];
}

@end
