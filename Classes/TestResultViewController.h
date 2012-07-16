//
//  TestResultViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestResultViewController : UITableViewController {
    int _testID, _totalScore;
    NSString *_testName;
    NSDictionary *_resultDictionary;
}

@property(nonatomic, copy)NSString *testName;
@property(nonatomic)int testID, totalScore;

- (void)addMenuToolBar;
@end
