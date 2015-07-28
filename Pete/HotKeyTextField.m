//
//  HotKeyTextField.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "HotKeyTextField.h"

@interface HotKeyTextField ()<NSTextFieldDelegate>

@end

@implementation HotKeyTextField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)commonInit {
  self.bezelStyle = NSTextFieldRoundedBezel;
  self.delegate = self;
}

- (instancetype)init {
  self = [super init];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (BOOL)textShouldBeginEditing:(NSText *)textObject {
  return NO;
}

@end
