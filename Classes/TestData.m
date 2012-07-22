//
//  TestData.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import "TestData.h"
#import "constants.h"

@implementation TestData

@synthesize pregunta = _pregunta, r1 = _r1, r2 = _r2, r3 = _r3, r4 = _r4, r5 = _r5, r6 = _r6, r7 = _r7, v = _v, escala_id = _escala_id, orden = _orden, multiple = _multiple, isSelected = _isSelected, imageData = _imageData;

- (id)init {
    [super init];
    if (self) {
        _v = (int*)malloc(7*sizeof(int));
        _isSelected = (int*)malloc(7*sizeof(int));
        for (int i=0; i < 7; i++) {
            _isSelected[i] = 0;
        }
    }
    return self;
}

- (int)getTotalValidOptions {
    int total = 0;
    if (![_r1 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r2 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r3 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r4 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r5 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r6 isEqualToString:BLANK_STRING]) {
        total++;
    }
    if (![_r7 isEqualToString:BLANK_STRING]) {
        total++;
    }
    
    return total;
}

- (void)dealloc {
    free(_isSelected);
    free(_v);
    [_imageData release], _imageData = nil;
    [_pregunta release], _pregunta = nil;
    [_r1 release], _r1 = nil;
    [_r2 release], _r2 = nil;
    [_r3 release], _r3 = nil;
    [_r4 release], _r4 = nil;
    [_r5 release], _r5 = nil;
    [_r6 release], _r6 = nil;
    [_r7 release], _r7 = nil;
    [super dealloc];
}
@end
