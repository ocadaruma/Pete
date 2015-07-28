//
//  KeyCodeConverter.m
//  Aladdin
//
//  Created by hokada on 7/27/15.
//  Copyright (c) 2015 Haruki Okada. All rights reserved.
//

#import "KeyCodeConverter.h"

static NSDictionary* _keyCodeMap = nil;
NSNumber* keyCodeOfString(NSString* str) {
  if (!_keyCodeMap) {
    _keyCodeMap = @{
                    @"0": @(0x1D), @"1": @(0x12), @"2": @(0x13), @"3": @(0x14),
                    @"4": @(0x15), @"5": @(0x17), @"6": @(0x16), @"7": @(0x1A),
                    @"8": @(0x1C), @"9": @(0x19), @"A": @(0x00), @"B": @(0x0B),
                    @"C": @(0x08), @"D": @(0x02), @"E": @(0x0E), @"F": @(0x03),
                    @"G": @(0x05), @"H": @(0x04), @"I": @(0x22), @"J": @(0x26),
                    @"K": @(0x28), @"L": @(0x25), @"M": @(0x2E), @"N": @(0x2D),
                    @"O": @(0x1F), @"P": @(0x23), @"Q": @(0x0C), @"R": @(0x0F),
                    @"S": @(0x01), @"T": @(0x11), @"U": @(0x20), @"V": @(0x09),
                    @"W": @(0x0D), @"X": @(0x07), @"Y": @(0x10), @"Z": @(0x06)
                    };
  }

  return _keyCodeMap[str];
}

static NSDictionary* _codeKeyMap = nil;
NSString* stringOfKeyCode(NSNumber* code) {
  if (!_codeKeyMap) {
    _codeKeyMap = @{
                    @(0x1D): @"0", @(0x12): @"1", @(0x13): @"2", @(0x14): @"3",
                    @(0x15): @"4", @(0x17): @"5", @(0x16): @"6", @(0x1A): @"7",
                    @(0x1C): @"8", @(0x19): @"9", @(0x00): @"A", @(0x0B): @"B",
                    @(0x08): @"C", @(0x02): @"D", @(0x0E): @"E", @(0x03): @"F",
                    @(0x05): @"G", @(0x04): @"H", @(0x22): @"I", @(0x26): @"J",
                    @(0x28): @"K", @(0x25): @"L", @(0x2E): @"M", @(0x2D): @"N",
                    @(0x1F): @"O", @(0x23): @"P", @(0x0C): @"Q", @(0x0F): @"R",
                    @(0x01): @"S", @(0x11): @"T", @(0x20): @"U", @(0x09): @"V",
                    @(0x0D): @"W", @(0x07): @"X", @(0x10): @"Y", @(0x06): @"Z"
                    };
  }

  return _codeKeyMap[code];
}