//
//  ViewControllerBase.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerBase : UITableViewController <UISearchBarDelegate> {
    NSMutableArray *_testData;
    UISearchBar *_searchBar;
}

@end
