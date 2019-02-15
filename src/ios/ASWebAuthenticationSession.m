#import <Availability.h>
#import "ASWebAuthenticationSession.h"

#import <AuthenticationServices/ASWebAuthenticationSession.h>

#import <Cordova/CDVAvailability.h>

ASWebAuthenticationSession *_authenticationVC;


@implementation ASWebAuthenticationSession;

- (void)pluginInitialize {
}

- (void)start:(CDVInvokedUrlCommand *)command {

    printf("hello1");
    if (@available(iOS 12.0, *)) {
      printf("hello2");
        NSString* redirectScheme = [command.arguments objectAtIndex:0];
        NSURL* requestURL = [NSURL URLWithString:[command.arguments objectAtIndex:1]];
        ASWebAuthenticationSession* authenticationVC =
        [[ASWebAuthenticationSession alloc] initWithURL:requestURL
                                   callbackURLScheme:redirectScheme
                                   completionHandler:^(NSURL * _Nullable callbackURL,
                                                       NSError * _Nullable error) {
                                       _authenticationVC = nil;
                                       CDVPluginResult *result;
                                       if (callbackURL) {
                                           result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: callbackURL.absoluteString];

                                       } else {
                                           result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
                                       }
                                       [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                                   }];
        _authenticationVC = authenticationVC;
        [authenticationVC start];
    }
}

@end
