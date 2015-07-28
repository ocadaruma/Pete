//
//  PTTextWindowController.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "TextWindowController.h"

@interface TextWindowController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation TextWindowController

- (void)windowDidLoad {
  [super windowDidLoad];
    
  // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

+ (instancetype)controller {
  return [[self alloc] initWithWindowNibName:@"TextWindowController"];
}

@end
