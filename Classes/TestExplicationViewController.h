//
//  TestExplicationViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestExplicationViewController : UITableViewController {
    int _testID;
    NSString *_testName;
    BOOL _isExplication;
    NSString *content;
}

@property(nonatomic, copy)NSString *testName;
@property(nonatomic)int testID;
@property(nonatomic)BOOL isExplication;
@end
