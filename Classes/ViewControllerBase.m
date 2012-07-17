//
//  ViewControllerBase.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#import "ViewControllerBase.h"
#import "DatabaseController.h"
#import "TestViewController.h"
#import "constants.h"

@implementation ViewControllerBase

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
    self.navigationItem.title = APP_TITLE;
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _testData = [dbController selectFromEscala:SQL_QUERY_ESCALA];
    [_testData retain];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HEIGHT_SEARCH_BAR)];
	_searchBar.delegate = self;
	//_searchBar.tintColor = [UIColor blueColor];
	_searchBar.placeholder = @"Enter search text";
    self.tableView.tableHeaderView = _searchBar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc
{
    [_searchBar release], _searchBar = nil;
    [_testData release], _testData = nil;
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
    return [_testData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSMutableDictionary *dict = [_testData objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKey:DB_FIELD_ESCALA];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
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
    NSMutableDictionary *dict = [_testData objectAtIndex:indexPath.row];
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.testID = [[dict valueForKey:DB_FIELD_ID] intValue];
    testVC.testName = [dict valueForKey:DB_FIELD_ESCALA];
    [self.navigationController pushViewController:testVC animated:YES];
    [testVC release], testVC = nil;
}

#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {  
	searchBar.showsScopeBar = YES;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:YES animated:YES];  
	
	return YES;  
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {  
	searchBar.showsScopeBar = NO;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:NO animated:YES];  
	return YES;  
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[_searchBar resignFirstResponder];
 //   [self loadData];
}
@end
