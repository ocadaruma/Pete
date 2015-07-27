//
//  HotKeyManager.m
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "HotKeyManager.h"
#import <Carbon/Carbon.h>

static const NSUInteger kEventHotKeyPressedSubtype = 6;

static OSStatus globalHotkeyHandler(EventHandlerCallRef, EventRef, void *);

@interface HotKeyManager ()

@property (nonatomic) NSMutableDictionary* targetDict;

@end

@implementation HotKeyManager

- (void *)registerHotKeyCode:(UInt32)keyCode withModifier:(UInt32)keyModifier handler:(void(^)(void))handler {
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
    return NULL;
  }

  _targetDict[@((int)hotKeyRef)] = [handler copy];

  return (void *)hotKeyRef;
}

- (void)unregisterHotKey:(void *)hotKeyRef {
  OSStatus err;

  err = UnregisterEventHotKey(hotKeyRef);
  [_targetDict removeObjectForKey:@((int)hotKeyRef)];
}

- (instancetype)init {
  self = [super init];

  if (self) {
    self.targetDict = [NSMutableDictionary dictionary];

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
    EventHotKeyRef hotKeyRef = (EventHotKeyRef)event.data1;
    void(^handler)() = app.targetDict[@((int)hotKeyRef)];
    if (handler) {
      handler();
    }
  }

  return noErr;
}
