//
//  MainWindow.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "MainWindow.h"
#import "KeyCodeConverter.h"
#import "PreferenceManager.h"
//#import <MASShortcut/Shortcut.h>

@interface MainWindow ()

@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSSlider *slider;

@end

@implementation MainWindow

- (void)commonInit {
  _colorWell.color = [PreferenceManager sharedManager].backgroundColor;
  _slider.floatValue = [PreferenceManager sharedManager].opacity;
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
