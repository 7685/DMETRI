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
#import "TestNames.h"
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
    _arr = [[NSArray alloc] initWithObjects:@"{search}", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _testData = [[NSMutableArray alloc] init];
    for (int i=0; i<[_arr count]; i++) {
        NSMutableArray *tempArray = [dbController selectFromEscala:[NSString stringWithFormat:SQL_QUERY_ESCALA, [_arr objectAtIndex:i]]];
        if ([tempArray count] != 0) {
            TestNames *testNames = [[TestNames alloc] init];
            testNames.startAlphabet = [_arr objectAtIndex:i];
            testNames.tests = tempArray;
            [_testData addObject:testNames];
            [testNames release], testNames = nil;
        }
    }
    _allTestData = [dbController selectFromEscala:SQL_QUERY_ALL_ESCALA];
    [_allTestData retain];
    [dbController release], dbController = nil;
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HEIGHT_SEARCH_BAR)];
	_searchBar.delegate = self;
    _searchBar.text = BLANK_STRING;
	//_searchBar.tintColor = [UIColor blueColor];
	_searchBar.placeholder = SEARCH_TITLE;
    self.tableView.tableHeaderView = _searchBar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc
{
    [_arr release], _arr = nil;
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
    if ([_searchBar.text isEqualToString:BLANK_STRING]) {
        return [_testData count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([_searchBar.text isEqualToString:BLANK_STRING]) {
        TestNames *testNames = [_testData objectAtIndex:section];
        return [testNames.tests count];
    }
    else {
        return [_allTestData count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *arr;
    // Configure the cell...
    if ([_searchBar.text isEqualToString:BLANK_STRING]) {
        TestNames *testName = [_testData objectAtIndex:indexPath.section];
        arr = [testName.tests objectAtIndex:indexPath.row];
        
    }
    else {
        arr = [_allTestData objectAtIndex:indexPath.row];
    }
    CGSize maximumLabelSize = CGSizeMake(300,20000);
    CGSize expectedLabelSize = [[arr valueForKey:DB_FIELD_ESCALA] sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_HEIGHT] 
                                                 constrainedToSize:maximumLabelSize 
                                                     lineBreakMode:UILineBreakModeWordWrap];
    return expectedLabelSize.height + 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSMutableDictionary *arr;
    // Configure the cell...
    if ([_searchBar.text isEqualToString:BLANK_STRING]) {
        TestNames *testName = [_testData objectAtIndex:indexPath.section];
        arr = [testName.tests objectAtIndex:indexPath.row];

    }
    else {
        arr = [_allTestData objectAtIndex:indexPath.row];
    }
    
    CGSize maximumLabelSize = CGSizeMake(300,20000);
    CGSize expectedLabelSize = [[arr valueForKey:DB_FIELD_ESCALA] sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_HEIGHT] 
                                                              constrainedToSize:maximumLabelSize 
                                                                  lineBreakMode:UILineBreakModeWordWrap];
    
    cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    cell.textLabel.text = [arr valueForKey:DB_FIELD_ESCALA];
    cell.textLabel.numberOfLines = 5;
    cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, expectedLabelSize.height + 20);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if(_isSearching)
        return -1;
    if ([title isEqualToString:@"{search}"]) {
        [tableView scrollRectToVisible:[[tableView tableHeaderView] bounds] animated:NO];
        return -1;
    }
    for (int i=0; i < [_testData count]; i++) {
        TestNames *testName = [_testData objectAtIndex:i];
        if ([testName.startAlphabet isEqualToString:title]) {
            return i;
        }
    }
    return -1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isSearching || ![_searchBar.text isEqualToString:BLANK_STRING]) {
        return nil;
    }
    TestNames *testName = [_testData objectAtIndex:section];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, SECTION_HEADER_HEIGHT)];
    
	header.backgroundColor = [UIColor lightGrayColor];
	
	UILabel *leftLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 10)];
	leftLbl.textColor = [UIColor whiteColor];
	leftLbl.backgroundColor = [UIColor clearColor];
	leftLbl.font = [UIFont boldSystemFontOfSize:10.0];
	leftLbl.text = testName.startAlphabet;
	
	[header addSubview:leftLbl];
	[leftLbl release];
	
	return [header autorelease];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_isSearching || ![_searchBar.text isEqualToString:BLANK_STRING]) {
        return nil;
    }
	return _arr;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestNames *testName = [_testData objectAtIndex:indexPath.section];
    NSMutableArray *arr = [testName.tests objectAtIndex:indexPath.row];
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.testID = [[arr valueForKey:DB_FIELD_ID] intValue];
    testVC.testName = [arr valueForKey:DB_FIELD_ESCALA];
    [self.navigationController pushViewController:testVC animated:YES];
    [testVC release], testVC = nil;
}

#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {  
    _isSearching = YES;
	searchBar.showsScopeBar = YES;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:YES animated:YES];  
	
	return YES;  
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_allTestData release], _allTestData = nil;
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _allTestData = [dbController selectFromEscala:[NSString stringWithFormat:SQL_QUERY_SEARCH_ESCALA, searchText]];
    [_allTestData retain];
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {  
	searchBar.showsScopeBar = NO;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:NO animated:YES];  
	return YES;  
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _isSearching = NO;
	[_searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[_searchBar resignFirstResponder];
}
@end
