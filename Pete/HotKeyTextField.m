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

- (void)commonInit {
  self.bezelStyle = NSTextFieldRoundedBezel;
  self.delegate = self;
  NSTextView* fieldEditor = (NSTextView *)[self.window fieldEditor:YES forObject:self];
  fieldEditor.insertionPointColor = [NSColor clearColor];
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

- (void)_d {

}

//- (BOOL)becomeFirstResponder {
//  BOOL status = [super becomeFirstResponder];
//
//  if (status) {
//    self.placeholderString = @"";
//    self.stringValue = @"";
//  }
//
//  return status;
//}

- (BOOL)textShouldBeginEditing:(NSText *)textObject {
  return NO;
}

@end
