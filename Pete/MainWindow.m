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
#import "PreferenceManager.h"

@interface MainWindow ()

@property (weak) IBOutlet NSTextField *hotKeyTextField;
@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSSlider *slider;

@end

@implementation MainWindow

- (void)intercept:(NSEvent *)theEvent {
  id firstResponder = (id)self.firstResponder;
  if ([firstResponder respondsToSelector:@selector(delegate)] &&
      [firstResponder delegate] == _hotKeyTextField) {
    if (NSEventMaskFromType(theEvent.type) & (NSKeyDownMask | NSKeyUpMask | NSFlagsChangedMask)) {
      NSString* hotKeyString = stringOfModifier(theEvent.modifierFlags);
      NSString* keyStr = stringOfKeyCode(@(theEvent.keyCode));
      _hotKeyTextField.placeholderString = hotKeyString;

      if (hotKeyString.length > 0 && keyStr){
        _hotKeyTextField.stringValue = [hotKeyString stringByAppendingString:keyStr];
        HotKey hotKey;
        hotKey.modifier = theEvent.modifierFlags;
        hotKey.keyCode = theEvent.keyCode;
        [PreferenceManager sharedManager].hotKey = hotKey;
        [[HotKeyManager sharedManager] unregisterHotKey];
        [[HotKeyManager sharedManager] registerHotKeyCode:hotKey.keyCode withModifier:hotKey.modifier];
      }
    }
  }

  [super sendEvent:theEvent];
}

- (void)sendEvent:(NSEvent *)theEvent {
  [self intercept:theEvent];
}

- (void)commonInit {
  _colorWell.color = [PreferenceManager sharedManager].backgroundColor;
  _slider.floatValue = [PreferenceManager sharedManager].opacity;

  HotKey hotKey = [PreferenceManager sharedManager].hotKey;
  _hotKeyTextField.stringValue = [stringOfModifier(hotKey.modifier) stringByAppendingString:stringOfKeyCode(@(hotKey.keyCode))];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self commonInit];
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

- (IBAction)colorChange:(id)sender {
  NSColorWell* colorWell = sender;
  [PreferenceManager sharedManager].backgroundColor = colorWell.color;
}

- (IBAction)opacityChange:(id)sender {
  NSSlider* slider = sender;
  [PreferenceManager sharedManager].opacity = slider.floatValue;
}

@end
