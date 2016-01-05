//
//  TextPanel.m
//  Pete
//
//  Created by hokada on 7/29/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "TextPanel.h"
#import "PreferenceManager.h"

@interface TextPanel ()

@property (nonatomic) NSPoint previousPoint;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation TextPanel

- (void)mouseDown:(NSEvent *)theEvent {
  self.previousPoint = [theEvent locationInWindow];
}

- (void)mouseDragged:(NSEvent *)theEvent {
  NSPoint p = [NSEvent mouseLocation];

  [self setFrame:NSMakeRect(p.x - _previousPoint.x,
                            p.y - _previousPoint.y,
                            self.frame.size.width,
                            self.frame.size.height)
         display:YES
         animate:NO];
}

- (void)commonInit {
  [self setLevel:NSFloatingWindowLevel];
  [self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary];
  self.opaque = NO;
  [self updateFromPreference];
}

- (void)updateFromPreference {
  PreferenceManager* prefManager = [PreferenceManager sharedManager];
  self.backgroundColor = [prefManager.backgroundColor colorWithAlphaComponent:prefManager.opacity];
  self.textView.editable = prefManager.editable;
}

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
  if (theEvent.modifierFlags & NSCommandKeyMask) {
    if ([theEvent.characters isEqualToString:@"w"]) {
      [self cancelOperation:nil];
      return YES;
    } else if ([theEvent.characters isEqualToString:@"q"]) {
      return YES;
    } else {
      return [super performKeyEquivalent:theEvent];
    }
  } else {
    return [super performKeyEquivalent:theEvent];
  }
}

- (void)cancelOperation:(id)sender {
  [self close];
}

- (BOOL)canBecomeKeyWindow {
  return YES;
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

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag screen:screen];

  if (self) {
    [self commonInit];
  }
  
  return self;
}

@end
