//
//  PreferenceManager.m
//  Pete
//
//  Created by hokada on 7/29/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "PreferenceManager.h"

static NSString* const kStoredOpacityKey = @"opacity";
static NSString* const kStoredBackgroundColorKey = @"backgroundColor";
static NSString* const kStoredEditableFlagKey = @"editable";
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

- (CGFloat)opacity {
  return [[NSUserDefaults standardUserDefaults] floatForKey:kStoredOpacityKey];
}

- (BOOL)editable {
  return [[NSUserDefaults standardUserDefaults] boolForKey:kStoredEditableFlagKey];
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

- (void)setEditable:(BOOL)editable {
  [[NSUserDefaults standardUserDefaults] setBool:editable forKey:kStoredEditableFlagKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (instancetype)init {
  self = [super init];

  if (self) {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kConfiguredFlagKey]) {
      self.backgroundColor = [NSColor whiteColor];
      self.opacity = 1.0f;
      self.editable = YES;

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
