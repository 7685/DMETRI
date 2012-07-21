//
//  TestNames.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestNames : NSObject {
    NSString *_startAlphabet;
    NSMutableArray *_tests;
}

@property(nonatomic, copy)NSString *startAlphabet;
@property(nonatomic, copy)NSMutableArray *tests;
@end
