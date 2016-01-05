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

  [_textView paste:nil];

  [_textView.textStorage.mutableString replaceOccurrencesOfString:@"\u2028|\u2029"
                                                       withString:@"\n"
                                                          options:NSRegularExpressionSearch
                                                            range:NSMakeRange(0, _textView.textStorage.mutableString.length)];


  [_textView scrollToBeginningOfDocument:nil];
  _textView.editable = [PreferenceManager sharedManager].editable;
}

+ (instancetype)controller {
  return [[self alloc] initWithWindowNibName:@"TextPanelController"];
}

@end
