//
//  PreferenceManager.h
//  Pete
//
//  Created by hokada on 7/29/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

struct HotKey {
  NSEventModifierFlags modifier;
  unsigned short keyCode;
};
typedef struct HotKey HotKey;

@interface PreferenceManager : NSObject

@property (nonatomic) NSColor* backgroundColor;
@property (nonatomic) CGFloat opacity;
@property (nonatomic) HotKey hotKey;

+ (instancetype)sharedManager;

@end
