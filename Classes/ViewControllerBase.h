//
//  ViewControllerBase.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerBase : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_testData, *_allTestData;
    UISearchBar *_searchBar;
    BOOL _isSearching;
    NSArray *_arr;
    UIToolbar *_toolbar;
}

@end
