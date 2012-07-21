//
//  TestNames.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "TestNames.h"

@implementation TestNames

@synthesize tests = _tests, startAlphabet = _startAlphabet;

- (id)init {
    self = [super init];
    return self;
}

- (int)getTotalTests {
    return [_tests count];
}

- (void)dealloc {
    [_tests release], _tests = nil;
    [_startAlphabet release], _startAlphabet = nil;
    [super dealloc];
}
@end
