//
//  KeyCodeConverter.h
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

extern NSNumber* keyCodeOfString(NSString* str);
extern NSString* stringOfKeyCode(NSNumber* code);
extern NSString* stringOfModifier(NSEventModifierFlags modifier);