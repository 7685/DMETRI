//
//  TestResultViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import "TestResultViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DatabaseController.h"
#import "constants.h"

@implementation TestResultViewController

@synthesize testID = _testID, totalScore = _totalScore, testName = _testName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _testName;
    self.tableView.scrollEnabled = NO;
    DatabaseController *dbController = [[DatabaseController alloc] init];
    NSLog(@"%@", [NSString stringWithFormat:SQL_QUERY_GET_SCORE_STRING, _testID, _totalScore]);
    _resultDictionary = [dbController getResultString:[NSString stringWithFormat:SQL_QUERY_GET_SCORE_STRING, _testID, _totalScore]];
    [_resultDictionary retain];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 340)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 8.0f;
    contentView.layer.borderColor = [UIColor grayColor].CGColor;
    contentView.layer.borderWidth = 1.0;
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0, 5);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.masksToBounds = NO;
    contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:contentView.bounds].CGPath;

    
    NSString *descriptionText = [NSString stringWithFormat:@"%@\n\n%@", [_resultDictionary valueForKey:DB_FIELD_DESCRIPCION1], [_resultDictionary valueForKey:DB_FIELD_DESCRIPCION2]];
    
//    CGSize maximumLabelSize = CGSizeMake(300,20000);
//    CGSize expectedLabelSize = [descriptionText sizeWithFont:[UIFont systemFontOfSize:18] 
//                                                 constrainedToSize:maximumLabelSize 
//                                                     lineBreakMode:UILineBreakModeWordWrap]; 
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 290, 320)];
    //description.numberOfLines = 30;
    description.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    description.scrollEnabled = YES;
    [description setText:descriptionText];
//    description.text = @"At fifth screen are valid what have we said for the fourth screen. In both screens white region has to be more height.\n\n   Filling the database we have found a problem that we don’t know if could be easy to solve. Text fields have 255 maximum long characters. It’s possible to have longer fields in SQLite?\n\nAt your second and third screen, you will have to change the back button with the new company name (D-Health). For the lower region you have two possibilities. Yo u can make a bit bigger this region or in the other hand you can make the red (or green) region a bit smaller, so we think it looks better. In this screen we would like to know how it looks some longer answer. Could you send to us an example?";
    description.backgroundColor = [UIColor clearColor];
    
    [contentView addSubview:description];
    [self.view addSubview:contentView];
    [contentView release], contentView = nil;
    [description release], description = nil;
    
    [self addMenuToolBar];
}

- (void)dealloc 
{
    [_testName release], _testName = nil;
    [_resultDictionary release], _resultDictionary = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem.title = APP_TITLE;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - custom methods
- (void)addMenuToolBar {
	//create toolbar using new
	UIToolbar *toolbar = [UIToolbar new];
	toolbar.barStyle = UIBarStyleDefault;
	[toolbar sizeToFit];
	toolbar.frame = CGRectMake(0, self.view.frame.size.height-44*2, [[UIScreen mainScreen] bounds].size.width, 44);
	
    UIButton *scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreBtn.frame = CGRectMake(0, 6, 45, 34);
    [scoreBtn.layer setCornerRadius:8.0f];
    [scoreBtn.layer setMasksToBounds:YES];
    [scoreBtn.layer setBorderWidth:1.0f];
    [scoreBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    scoreBtn.backgroundColor = [UIColor redColor];
    [scoreBtn setTitle:[NSString stringWithFormat:@"%d", _totalScore] forState:UIControlStateNormal];
    [scoreBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:0.55 blue:0.27 alpha:1.0]];
    
    UILabel *testStatusText = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 150, 40)];
    testStatusText.backgroundColor = [UIColor clearColor];
    [testStatusText setFont:[UIFont boldSystemFontOfSize:16.0]];
    testStatusText.text = TEST_RESULT_TEXT;
    
    UIBarButtonItem *scoreBarBtn = [[UIBarButtonItem alloc] initWithCustomView:scoreBtn];
    UIBarButtonItem *testStatusTextBarBtn = [[UIBarButtonItem alloc] initWithCustomView:testStatusText];    
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	//Add buttons to the array
	NSArray *items = [NSArray arrayWithObjects:scoreBarBtn, flexItem, testStatusTextBarBtn, flexItem, nil];
	//release buttons
	[flexItem release];
	//add array of buttons to toolbar
	[toolbar setItems:items animated:NO];
	[self.view addSubview:toolbar];
}

@end
