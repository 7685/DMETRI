//
//  TestViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestData;

@interface TestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    int _testID, _totalScore;
    NSString *_testName;
    TestData *_testData;
    NSMutableArray *_testQuestions;
    UITableView *_tableView;
    UIBarButtonItem *_plusBtn;
    UIButton *_scoreBtn;
    UILabel *_testStatusText;
    UIToolbar *_toolbar;
}

@property(nonatomic)int testID;
@property(nonatomic, copy)NSString *testName;

- (void)addMenuToolBar;
- (void)updateScore;
@end
