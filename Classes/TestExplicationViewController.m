//
//  TestExplicationViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 16/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import "TestExplicationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DatabaseController.h"
#import "constants.h"

@implementation TestExplicationViewController

@synthesize testID = _testID, testName = _testName;

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
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView)] autorelease];
    
    DatabaseController *dbController = [[DatabaseController alloc] init];
    NSString *descriptionText = [dbController getTestDescription:[NSString stringWithFormat:SQL_QUERY_GET_TEST_DESCRIPTION, _testID]];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 8.0f;
    contentView.layer.borderColor = [UIColor grayColor].CGColor;
    contentView.layer.borderWidth = 1.0;
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0, 5);
//    contentView.layer.shadowRadius = 20;
    contentView.layer.shadowOpacity = 1;
    contentView.layer.masksToBounds = NO;
    contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:contentView.bounds].CGPath;
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 290, 380)];
    description.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    description.scrollEnabled = YES;
    [description setText:descriptionText];
    description.backgroundColor = [UIColor clearColor];
    description.editable = NO;
    
    [contentView addSubview:description];
    [self.view addSubview:contentView];
    self.tableView.scrollEnabled = NO;
    
    [contentView release], contentView = nil;
    [description release], description = nil;
}

- (void)dealloc 
{
    [_testName release], _testName = nil;
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
- (void)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

@end
