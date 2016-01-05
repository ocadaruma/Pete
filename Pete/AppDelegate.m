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
#import "PreferenceManager.h"
#import "TextPanel.h"
#import <MASShortcut/Shortcut.h>

static NSString *const kHotKeyPreferenceKey = @"HotKey";
static NSString *const kSwapPanelHiddenHotKeyPreferenceKey = @"SwapPanelHiddenHotKey";

@interface AppDelegate ()<NSWindowDelegate>

@property (weak) IBOutlet MASShortcutView *shortcutView;
@property (weak) IBOutlet MASShortcutView *swapPanelHiddenShortcutView;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (nonatomic) NSMutableSet* panels;
@property (nonatomic) NSStatusItem* statusItem;
@property (nonatomic) BOOL panelsHidden;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [self avoidDuplicateRunning];

  // Insert code here to initialize your application
  self.panels = [NSMutableSet set];
  self.panelsHidden = NO;

  //statusbar initialization
  NSStatusBar* statusBar = [NSStatusBar systemStatusBar];
  self.statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
  [_statusItem setImage:[NSImage imageNamed:@"statusbar"]];
  [_statusItem setMenu:_statusMenu];

  //preference initialization

  /**
   Shortcut for Popup
   */
  _shortcutView.associatedUserDefaultsKey = kHotKeyPreferenceKey;
  _shortcutView.style = MASShortcutViewStyleDefault;
  MASShortcut* shortcut = [MASShortcut shortcutWithKeyCode:keyCodeOfString(@"A").integerValue
                                             modifierFlags:NSCommandKeyMask | NSShiftKeyMask];
  [[MASShortcutBinder sharedBinder] registerDefaultShortcuts:@{kHotKeyPreferenceKey: shortcut}];
  [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:kHotKeyPreferenceKey toAction:^{
    TextPanelController* ctrl = [TextPanelController controller];
    [_panels addObject:ctrl.window];

    ctrl.window.delegate = self;
    [ctrl showWindow: nil];
    [NSApp activateIgnoringOtherApps:YES];
  }];

  /**
   Shortcut for swap panel hidden
   */
  _swapPanelHiddenShortcutView.associatedUserDefaultsKey = kSwapPanelHiddenHotKeyPreferenceKey;
  _swapPanelHiddenShortcutView.style = MASShortcutViewStyleDefault;
  MASShortcut* swapPanelHiddenShortcut = [MASShortcut shortcutWithKeyCode:keyCodeOfString(@"M").integerValue
                                             modifierFlags:NSCommandKeyMask | NSShiftKeyMask];
  [[MASShortcutBinder sharedBinder] registerDefaultShortcuts:@{kSwapPanelHiddenHotKeyPreferenceKey: swapPanelHiddenShortcut}];
  [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:kSwapPanelHiddenHotKeyPreferenceKey toAction:^{
    [_panels enumerateObjectsUsingBlock:^(NSWindow* w, BOOL *stop) {
      if (_panelsHidden) {
        [w makeKeyAndOrderFront:w];
      } else {
        [w orderOut:w];
      }
    }];
    self.panelsHidden = !_panelsHidden;
  }];
}

- (void)avoidDuplicateRunning {
  if ([NSRunningApplication
       runningApplicationsWithBundleIdentifier:[NSBundle mainBundle].bundleIdentifier].count > 1) {
    [NSApp terminate:nil];
  }
}

- (IBAction)colorChange:(id)sender {
  NSColorWell* colorWell = sender;
  [PreferenceManager sharedManager].backgroundColor = colorWell.color;
  [_panels enumerateObjectsUsingBlock:^(TextPanel* panel, BOOL *stop) {
    [panel updateFromPreference];
  }];
}

- (IBAction)opacityChange:(id)sender {
  NSSlider* slider = sender;
  [PreferenceManager sharedManager].opacity = slider.floatValue;
  [_panels enumerateObjectsUsingBlock:^(TextPanel* panel, BOOL *stop) {
    [panel updateFromPreference];
  }];
}

- (IBAction)editableChange:(id)sender {
  NSButton* checkBox = sender;
  BOOL checked = checkBox.state == NSOnState;
  [PreferenceManager sharedManager].editable = checked;
  [_panels enumerateObjectsUsingBlock:^(TextPanel* panel, BOOL *stop) {
    [panel updateFromPreference];
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
