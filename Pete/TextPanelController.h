//
//  PTTextWindowController.h
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TextPanelController : NSWindowController

@property (nonatomic) NSString* string;
@property (nonatomic) NSAttributedString* attributedString;

+ (instancetype)controller;

@end
