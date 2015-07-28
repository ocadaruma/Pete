//
//  HotKeyTextView.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "HotKeyTextView.h"

@interface HotKeyTextView ()<NSTextViewDelegate>

@end

@implementation HotKeyTextView

- (void)commonInit {
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
//
//- (void)keyDown:(NSEvent *)theEvent {
//  [super keyDown:theEvent];
//}

//- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
//  NSLog(@"command");
//  return NO;
//}

- (BOOL)textShouldBeginEditing:(NSText *)textObject {
  return NO;
}

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
  NSLog(@"perform");
  return [super performKeyEquivalent:theEvent];
}

@end
