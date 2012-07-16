//
//  WindowBasedApplicationAppDelegate.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 shahshangraj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewControllerBase;

@interface WindowBasedApplicationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ViewControllerBase *viewControllerBase;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewControllerBase *viewControllerBase;

- (void)createEditableCopyOfDatabaseIfNeeded;

@end

