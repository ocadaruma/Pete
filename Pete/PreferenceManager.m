//
//  PreferenceManager.m
//  Pete
//
//  Created by hokada on 7/29/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "PreferenceManager.h"
#import "KeyCodeConverter.h"

static NSString* const kStoredModifierKey = @"modifier";
static NSString* const kStoredKeyCodeKey = @"keyCode";
static NSString* const kStoredOpacityKey = @"opacity";
static NSString* const kStoredBackgroundColorKey = @"backgroundColor";
static NSString* const kConfiguredFlagKey = @"configured";

@implementation PreferenceManager

- (NSColor *)backgroundColor {
  NSColor* color = nil;
  NSData* data = [[NSUserDefaults standardUserDefaults] dataForKey:kStoredBackgroundColorKey];
  if (data) {
    color = (NSColor *)[NSUnarchiver unarchiveObjectWithData:data];
  }
  return color;
}

- (HotKey)hotKey {
  HotKey key;

  key.modifier = [[NSUserDefaults standardUserDefaults] integerForKey:kStoredModifierKey];
  key.keyCode = [[NSUserDefaults standardUserDefaults] integerForKey:kStoredKeyCodeKey];

  return key;
}

- (CGFloat)opacity {
  return [[NSUserDefaults standardUserDefaults] floatForKey:kStoredOpacityKey];
}

- (void)setBackgroundColor:(NSColor *)backgroundColor {
  NSData* data = [NSArchiver archivedDataWithRootObject:backgroundColor];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:kStoredBackgroundColorKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setOpacity:(CGFloat)opacity {
  [[NSUserDefaults standardUserDefaults] setFloat:opacity forKey:kStoredOpacityKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHotKey:(HotKey)hotKey {
  [[NSUserDefaults standardUserDefaults] setInteger:hotKey.modifier forKey:kStoredModifierKey];
  [[NSUserDefaults standardUserDefaults] setInteger:hotKey.keyCode forKey:kStoredKeyCodeKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (instancetype)init {
  self = [super init];

  if (self) {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kConfiguredFlagKey]) {
      self.backgroundColor = [NSColor whiteColor];
      self.opacity = 1.0f;

      //デフォルトホットキーはCommand + Shift + A
      HotKey key;
      key.modifier = NSCommandKeyMask | NSShiftKeyMask;
      key.keyCode = keyCodeOfString(@"A").integerValue;
      self.hotKey = key;

      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kConfiguredFlagKey];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
  }

  return self;
}

+ (instancetype)sharedManager {
  static PreferenceManager* instance = nil;
  static dispatch_once_t token;

  dispatch_once(&token, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

@end
