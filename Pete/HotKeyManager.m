//
//  HotKeyManager.m
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "HotKeyManager.h"

static const NSUInteger kEventHotKeyPressedSubtype = 6;

static OSStatus globalHotkeyHandler(EventHandlerCallRef, EventRef, void *);

@interface HotKeyManager ()

@property (nonatomic) EventHotKeyRef currentHotKeyRef;

@end

@implementation HotKeyManager

- (void)registerHotKeyCode:(UInt32)keyCode withModifier:(UInt32)keyModifier {
  static UInt32 _id = 0;

  OSStatus err;
  UInt32 modifier;
  EventHotKeyID keyId;
  EventHotKeyRef hotKeyRef;

  modifier = 0;
  if (keyModifier & NSShiftKeyMask) modifier |= shiftKey;
  if (keyModifier & NSControlKeyMask) modifier |= controlKey;
  if (keyModifier & NSCommandKeyMask) modifier |= cmdKey;
  if (keyModifier & NSAlternateKeyMask) modifier |= optionKey;

  keyId.signature = 'HtKe';
  keyId.id = _id++;

  err = RegisterEventHotKey(keyCode, modifier, keyId, GetApplicationEventTarget(), 0, &hotKeyRef);
  if (err != noErr) {
    return;
  }

  self.currentHotKeyRef = hotKeyRef;
}

- (void)unregisterHotKey {
  if (_currentHotKeyRef) {
    UnregisterEventHotKey(_currentHotKeyRef);
  }
  self.currentHotKeyRef = NULL;
  self.handler = nil;
}

- (instancetype)init {
  self = [super init];

  if (self) {
    EventTypeSpec eventTypeSpecList[] ={
      { kEventClassKeyboard, kEventHotKeyPressed }
    };

    InstallApplicationEventHandler(globalHotkeyHandler,
                                   GetEventTypeCount(eventTypeSpecList),
                                   eventTypeSpecList,
                                   (__bridge void *)self,
                                   NULL);
  }

  return self;
}

+ (instancetype)sharedManager {
  static HotKeyManager* instance = nil;
  static dispatch_once_t token;

  dispatch_once(&token, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

@end

static OSStatus globalHotkeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
  NSEvent* event = [NSEvent eventWithEventRef:anEvent];
  HotKeyManager* app = (__bridge HotKeyManager*)userData;

  if (event.type == NSSystemDefined && event.subtype == kEventHotKeyPressedSubtype) {
    if (app.handler) {
      app.handler(event);
    }
  }

  return noErr;
}
