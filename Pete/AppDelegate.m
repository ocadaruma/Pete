//
//  AppDelegate.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "AppDelegate.h"
#import "TextWindowController.h"
#import "TextWindow.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) NSMutableSet* windowControllers;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  self.windowControllers = [NSMutableSet set];
}
- (IBAction)tapped:(id)sender {
  TextWindowController* ctrl = [TextWindowController controller];
  [_windowControllers addObject:ctrl];

  [_window beginSheet:ctrl.window completionHandler:^(NSModalResponse returnCode) {
    NSLog(@"here");
  }];
//  [ctrl showWindow:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
