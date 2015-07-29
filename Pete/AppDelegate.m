//
//  AppDelegate.m
//  Pete
//
//  Created by hokada on 7/28/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "AppDelegate.h"
#import "TextPanelController.h"
#import "KeyCodeConverter.h"
#import <MASShortcut/Shortcut.h>

static NSString *const kHotKeyPreferenceKey = @"HotKey";

@interface AppDelegate ()<NSWindowDelegate>

@property (weak) IBOutlet MASShortcutView *shortcutView;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (nonatomic) NSMutableSet* panels;
@property (nonatomic) NSStatusItem* statusItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  self.panels = [NSMutableSet set];

  //statusbar initialization
  NSStatusBar* statusBar = [NSStatusBar systemStatusBar];
  self.statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
  [_statusItem setImage:[NSImage imageNamed:@"statusbar"]];
  [_statusItem setMenu:_statusMenu];

  //preference initialization
  _shortcutView.associatedUserDefaultsKey = kHotKeyPreferenceKey;
  _shortcutView.style = MASShortcutViewStyleDefault;

  MASShortcut* shortcut = [MASShortcut shortcutWithKeyCode:keyCodeOfString(@"A").integerValue
                                             modifierFlags:NSCommandKeyMask | NSShiftKeyMask];

  [[MASShortcutBinder sharedBinder] registerDefaultShortcuts:@{kHotKeyPreferenceKey: shortcut}];
  [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:kHotKeyPreferenceKey toAction:^{
    TextPanelController* ctrl = [TextPanelController controller];
    [_panels addObject:ctrl.window];

    NSPasteboard* pb = [NSPasteboard generalPasteboard];
    NSData* data = nil;
    if ((data = [pb dataForType:NSRTFPboardType])) {
      NSAttributedString* str = [[NSAttributedString alloc] initWithRTF:data documentAttributes:nil];
      ctrl.attributedString = str;
    } else if ((data = [pb dataForType:NSHTMLPboardType])) {
      NSAttributedString* str = [[NSAttributedString alloc] initWithData:data
                                                                 options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                           NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                      documentAttributes:nil
                                                                   error:nil];
      ctrl.attributedString = str;
    } else if ((data = [pb dataForType:NSStringPboardType])) {
      NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      ctrl.string = str;
    }

    ctrl.window.delegate = self;
    [ctrl showWindow:nil];
    [NSApp activateIgnoringOtherApps:YES];
  }];
}

- (void)windowWillClose:(NSNotification *)notification {
  [_panels removeObject:notification.object];
}

- (IBAction)showMainWindow:(id)sender {
  [_window orderFront:nil];
  [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)showAbout:(id)sender {
  [NSApp orderFrontStandardAboutPanel:nil];
  [NSApp activateIgnoringOtherApps:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
