//
//  TextWindowView.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "TextPanelView.h"

@interface TextPanelView ()

@end

@implementation TextPanelView

- (IBAction)change:(id)sender {
  [_delegate change];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
  return YES;
}

@end
