//
//  HotKeyManager.h
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface HotKeyManager : NSObject

- (void *)registerHotKeyCode:(UInt32)keyCode withModifier:(UInt32)keyModifier handler:(void(^)(void))handler;
- (void)unregisterHotKey:(void *)hotKeyRef;
+ (instancetype)sharedManager;

@end
