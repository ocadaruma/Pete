//
//  MainWindow.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "MainWindow.h"
#import "HotKeyManager.h"
#import "KeyCodeConverter.h"

@interface MainWindow ()

@property (weak) IBOutlet NSTextField *hotKeyTextField;
@property (weak) IBOutlet NSButton *button;

@end

@implementation MainWindow

- (void)intercept:(NSEvent *)theEvent equivalent:(BOOL)equivalent {
  id firstResponder = (id)self.firstResponder;
  if ([firstResponder respondsToSelector:@selector(delegate)] &&
      [firstResponder delegate] == _hotKeyTextField) {
    if (NSEventMaskFromType(theEvent.type) & (NSKeyDownMask | NSKeyUpMask | NSFlagsChangedMask)) {
      NSMutableString* hotKeyString = [NSMutableString string];
      if (theEvent.modifierFlags & NSControlKeyMask) [hotKeyString appendString:@"^"];
      if (theEvent.modifierFlags & NSShiftKeyMask) [hotKeyString appendString:@"⇧"];
      if (theEvent.modifierFlags & NSCommandKeyMask) [hotKeyString appendString:@"⌘"];
      if (theEvent.modifierFlags & NSAlternateKeyMask) [hotKeyString appendString:@"⌥"];

      NSString* keyStr = stringOfKeyCode(@(theEvent.keyCode));
      _hotKeyTextField.placeholderString = hotKeyString;

      if (hotKeyString.length > 0 && keyStr){
        [hotKeyString appendString:keyStr];
        [self makeFirstResponder:nil];
        _hotKeyTextField.stringValue = hotKeyString;
      }
    }
  }

  if (!equivalent) {
    [super sendEvent:theEvent];
  }
}

- (void)sendEvent:(NSEvent *)theEvent {
  [self intercept:theEvent equivalent:NO];
}

- (void)commonInit {
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

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
  [self intercept:theEvent equivalent:YES];
  return [super performKeyEquivalent:theEvent];
}

@end
