//
//  LightIntentHandler.m
//  LightExt
//
//  Created by Jinya on 2020/1/8.
//  Copyright © 2020 Cocoa. All rights reserved.
//

#import "LightIntentHandler.h"

@implementation LightIntentHandler

- (void)handleLight:(nonnull LightIntent *)intent completion:(nonnull void (^)(LightIntentResponse * _Nonnull))completion {
    NSLog(@"===================");
    LightIntentResponse *response = [[LightIntentResponse alloc] initWithCode:LightIntentResponseCodeSuccess userActivity:nil];
    completion(response);
}

@end
