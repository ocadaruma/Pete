//
//  TextWindowView.h
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TextPanelViewDelegate <NSObject>

- (void)change;

@end

@interface TextPanelView : NSView

@property (nonatomic, weak) IBOutlet id<TextPanelViewDelegate> delegate;

@end
