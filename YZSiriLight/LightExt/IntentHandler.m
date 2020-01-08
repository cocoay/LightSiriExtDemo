//
//  IntentHandler.m
//  LightExt
//
//  Created by Jinya on 2020/1/8.
//  Copyright © 2020 Cocoa. All rights reserved.
//

#import "IntentHandler.h"
#import "LightIntentHandler.h"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@interface IntentHandler () 

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    NSLog(@"-------------: %@", intent);
    if ([intent isKindOfClass:[LightIntent class]]) {
        return [[LightIntentHandler alloc] init];
    }
    return self;
}

@end
