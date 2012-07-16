//
//  TestViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "TestViewController.h"
#import "TestExplicationViewController.h"
#import "TestResultViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DatabaseController.h"
#import "constants.h"
#import "TestData.h"

@implementation TestViewController

@synthesize testID = _testID, testName = _testName;

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
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(bookmarkBtnClicked)] autorelease];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - TOOLBAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self addMenuToolBar];
    
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _testQuestions = [dbController selectFromPreguntas:[NSString stringWithFormat:SQL_QUERY_PREGUNTAS, _testID]];
    [_testQuestions retain];
    [dbController release], dbController = nil;
}

- (void)dealloc {
    [_testName release], _testName = nil;
    [_testData release], _testData = nil;
    [_testQuestions release], _testQuestions = nil;
    [_plusBtn release], _plusBtn = nil;
    [_scoreBtn release], _scoreBtn = nil;
    [_testStatusText release], _testStatusText = nil;
    [_toolbar release], _toolbar = nil;
    [_tableView release], _tableView = nil;
    [super dealloc];
}

- (void)addMenuToolBar {
	//create toolbar using new
	_toolbar = [UIToolbar new];
	_toolbar.barStyle = UIBarStyleDefault;
	[_toolbar sizeToFit];
	_toolbar.frame = CGRectMake(0, self.view.frame.size.height-44*2, [[UIScreen mainScreen] bounds].size.width, 44);
	
    _scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _scoreBtn.frame = CGRectMake(0, 2, 50, 40);
    [_scoreBtn.layer setCornerRadius:8.0f];
    [_scoreBtn.layer setMasksToBounds:YES];
    [_scoreBtn.layer setBorderWidth:1.0f];
    [_scoreBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    _scoreBtn.backgroundColor = [UIColor redColor];
    [_scoreBtn setTitle:@"0" forState:UIControlStateNormal];
    [_scoreBtn setBackgroundColor:[UIColor redColor]];

    _testStatusText = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 150, 40)];
    _testStatusText.backgroundColor = [UIColor clearColor];
    [_testStatusText setFont:[UIFont boldSystemFontOfSize:16.0]];
    _testStatusText.text = TEST_INCOMPLETE;
    
    UIBarButtonItem *scoreBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_scoreBtn];
    UIBarButtonItem *testStatusTextBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_testStatusText];
    
    _plusBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusBtnClicked)];
    
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	//Add buttons to the array
	//NSArray *items = [NSArray arrayWithObjects: info, flexItem, prev, flexItem, next, nil];
	NSArray *items = [NSArray arrayWithObjects:scoreBarBtn, flexItem, testStatusTextBarBtn, flexItem,nil];
	//release buttons
	[flexItem release];
	//add array of buttons to toolbar
	[_toolbar setItems:items animated:NO];
	[self.view addSubview:_toolbar];
	
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TestData *tempTestData = [_testQuestions objectAtIndex:section];
    CGSize maximumLabelSize = CGSizeMake(300,20000);
    CGSize expectedLabelSize = [tempTestData.pregunta sizeWithFont:[UIFont systemFontOfSize:18] 
                                                             constrainedToSize:maximumLabelSize 
                                                                 lineBreakMode:UILineBreakModeWordWrap]; 
    int imageHeight = 0;
    if (![tempTestData.imageName isEqualToString:BLANK_STRING]) {
        imageHeight = IMG_TEST_HEIGHT + OFFSET_TEST_IMAGE;
    }
    
    return expectedLabelSize.height+imageHeight + OFFSET_TEST_TEXT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TestData *tempTestData = [_testQuestions objectAtIndex:section];

    CGSize maximumLabelSize = CGSizeMake(290,20000);
    CGSize expectedLabelSize = [tempTestData.pregunta sizeWithFont:[UIFont systemFontOfSize:18] 
                                                 constrainedToSize:maximumLabelSize 
                                                     lineBreakMode:UILineBreakModeWordWrap]; 
    
    int imageHeight = 0;
    if (![tempTestData.imageName isEqualToString:BLANK_STRING]) {
        imageHeight = IMG_TEST_HEIGHT + OFFSET_TEST_IMAGE;
    }
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, expectedLabelSize.height+imageHeight + OFFSET_TEST_TEXT)] autorelease];
//    headerView.backgroundColor = [UIColor whiteColor];

    UILabel *questionTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 290, expectedLabelSize.height + OFFSET_TEST_TEXT)];
    questionTextLabel.backgroundColor = [UIColor clearColor];
    questionTextLabel.adjustsFontSizeToFitWidth = YES;
    questionTextLabel.font = [UIFont systemFontOfSize:18];
    questionTextLabel.minimumFontSize = 18;
    questionTextLabel.numberOfLines = 10;
    questionTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    questionTextLabel.text = tempTestData.pregunta;
    [headerView addSubview:questionTextLabel];
    
    
    if (![tempTestData.imageName isEqualToString:BLANK_STRING]) {
        UIImageView *questionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_example.png"]];
        questionImageView.frame = CGRectMake(10, questionTextLabel.frame.size.height + OFFSET_TEST_IMAGE, 290, IMG_TEST_HEIGHT);
        [headerView addSubview:questionImageView];
        [questionImageView release], questionImageView = nil;
    }
    
    [questionTextLabel release], questionTextLabel = nil;
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_testQuestions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    TestData *tempTestData = [_testQuestions objectAtIndex:section];
    return [tempTestData getTotalValidOptions];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    // Configure the cell...
    TestData *tempTestData = [_testQuestions objectAtIndex:indexPath.section];
    if (tempTestData.isSelected[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = tempTestData.r1;
            break;
        case 1:
            cell.textLabel.text = tempTestData.r2;
            break;
        case 2:
            cell.textLabel.text = tempTestData.r3;
            break;
        case 3:
            cell.textLabel.text = tempTestData.r4;
            break;
        case 4:
            cell.textLabel.text = tempTestData.r5;
            break;
        case 5:
            cell.textLabel.text = tempTestData.r6;
            break;
        case 6:
            cell.textLabel.text = tempTestData.r7;
            break;
    }
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
    TestData *tempTestData = [_testQuestions objectAtIndex:indexPath.section];
    if (tempTestData.multiple) {
        if (tempTestData.isSelected[indexPath.row]) {
            tempTestData.isSelected[indexPath.row] = 0;
        }
        else {
            tempTestData.isSelected[indexPath.row] = 1;
        }
    }
    else {
        int lastState = tempTestData.isSelected[indexPath.row];
        for (int i=0; i < [tempTestData getTotalValidOptions]; i++) {
            tempTestData.isSelected[i] = 0;
        }
        if (lastState == 0) {
            tempTestData.isSelected[indexPath.row] = 1;
        }
    }
    [self updateScore];
    [_tableView reloadData];
}

#pragma mark - custom methods
- (void)updateScore {
    int testCompleted = 0;
    _totalScore = 0;
    for (int i=0; i < [_testQuestions count]; i++) {
        int oneOptionSelected = 0;
        TestData *tempTestData = [_testQuestions objectAtIndex:i];
        for (int j=0; j < 7; j++) {
            if (tempTestData.isSelected[j]) {
                _totalScore += tempTestData.v[j];
                oneOptionSelected++;
            }
        }
        if (oneOptionSelected > 0) {
            testCompleted++;
        }
    }
    if (testCompleted == [_testQuestions count]) {
        _testStatusText.text = TEST_COMPLETE;
        _scoreBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.55 blue:0.27 alpha:1.0];
        NSMutableArray     *items = [[_toolbar.items mutableCopy] autorelease];
        [items addObject:_plusBtn];
        _toolbar.items = items;
    }
    else {
        _testStatusText.text = TEST_INCOMPLETE;
        _scoreBtn.backgroundColor = [UIColor redColor];
        NSMutableArray     *items = [[_toolbar.items mutableCopy] autorelease];
        [items removeObject: _plusBtn];
        _toolbar.items = items;
    }
    
    [_scoreBtn setTitle:[NSString stringWithFormat:@"%d", _totalScore] forState:UIControlStateNormal];
}

- (void)plusBtnClicked {
    TestResultViewController *testResultVC = [[TestResultViewController alloc] initWithStyle:UITableViewStyleGrouped];
    testResultVC.totalScore = _totalScore;
    testResultVC.testID = _testID;
    testResultVC.testName = _testName;
    [self.navigationController pushViewController:testResultVC animated:YES];
    [testResultVC release], testResultVC = nil;
}

- (void)bookmarkBtnClicked {
    TestExplicationViewController *testExplicationVC = [[TestExplicationViewController alloc] initWithStyle:UITableViewStyleGrouped];
    testExplicationVC.testID = _testID;
    testExplicationVC.testName = _testName;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testExplicationVC];
    [self presentModalViewController:nav animated:YES];
    [testExplicationVC release], testExplicationVC = nil;
    [nav release], nav = nil;
}

@end
