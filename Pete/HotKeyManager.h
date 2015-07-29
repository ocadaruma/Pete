//
//  HotKeyManager.h
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface HotKeyManager : NSObject

@property (copy) void(^handler)(NSEvent *);

- (void)registerHotKeyCode:(UInt32)keyCode withModifier:(UInt32)keyModifier;
- (void)unregisterHotKey;
+ (instancetype)sharedManager;

@end
