//
//  TextWindow.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "TextWindow.h"

@interface TextWindow ()

@property (nonatomic) NSPoint previousPoint;

@end

@implementation TextWindow

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

//- (void)keyDown:(NSEvent *)theEvent {
//
//}

- (void)commonInit {
  [self setLevel:NSFloatingWindowLevel];
  [self setBackgroundColor:[NSColor whiteColor]];
  [self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary];
//  [self setStyleMask:NSNonactivatingPanelMask];
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
