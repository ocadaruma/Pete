//
//  PTTextWindowController.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "TextPanelController.h"
#import "PreferenceManager.h"

@interface TextPanelController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation TextPanelController

- (void)windowDidLoad {
  [super windowDidLoad];
}

- (void)setString:(NSString *)string {
  _string = string;
  if (_string) {
    _textView.string = _string;
  }
}

- (void)setAttributedString:(NSAttributedString *)attributedString {
  _attributedString = attributedString;
  if (_attributedString) {
    [_textView.textStorage appendAttributedString:_attributedString];
  }
}

+ (instancetype)controller {
  return [[self alloc] initWithWindowNibName:@"TextPanelController"];
}

@end
