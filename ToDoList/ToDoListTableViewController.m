//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Mohammed Safwat on 9/20/15.
//  Copyright (c) 2015 safwat. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoListTableViewCell.h"
#import "ToDoListData.h"
#import "MMWormhole.h"

#define TABLE_VIEW_CELL_HEIGHT 40

@interface ToDoListTableViewController ()
@property (nonatomic, strong) NSMutableArray *toDoListItems;
@property (nonatomic, strong) UITextField *toDoInputTextField;
@property (nonatomic, strong) MMWormhole *wormhole;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation ToDoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeValues];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self passWormholeMessage:[ToDoListData toDoListItems]];
    [self saveToUserDefaults:[ToDoListData toDoListItems]];
}

- (void)initializeValues {
    self.toDoListItems = [ToDoListData toDoListItems];
    self.tableView.tableHeaderView = [self toDoListTableViewHeader];
    self.toDoInputTextField.delegate = self;
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.safwat.development.ToDoList" optionalDirectory:@"wormhole"];
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.safwat.development.ToDoList"];
}

- (UIView*)toDoListTableViewHeader {
    UIView *tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, TABLE_VIEW_CELL_HEIGHT)];
    tableViewHeader.backgroundColor = [UIColor lightGrayColor];
    
    self.toDoInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, tableViewHeader.frame.size.width * 0.95, TABLE_VIEW_CELL_HEIGHT * 0.8)];
    self.toDoInputTextField.center = CGPointMake(tableViewHeader.center.x, tableViewHeader.center.y);
    self.toDoInputTextField.placeholder = @"Add an item..";
    self.toDoInputTextField.backgroundColor = [UIColor whiteColor];
    self.toDoInputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.toDoInputTextField.returnKeyType = UIReturnKeyDone;
    
    [tableViewHeader addSubview:self.toDoInputTextField];
    
    return tableViewHeader;
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(![self textIsEmpty:textField.text]) {
        [self.toDoListItems addObject:textField.text];
        [textField setText:@""];
        [self.tableView reloadData];
        //[self passWormholeMessage:[ToDoListData toDoListItems]];
        [self saveToUserDefaults:[ToDoListData toDoListItems]];
    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textIsEmpty:(NSString*)text {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [text stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.toDoListItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoListTableViewCell" forIndexPath:indexPath];
    cell.toDoItemTitle.text = self.toDoListItems[indexPath.row];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoListItems removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[self passWormholeMessage:[ToDoListData toDoListItems]];
        [self saveToUserDefaults:[ToDoListData toDoListItems]];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_VIEW_CELL_HEIGHT;
}

- (void)passWormholeMessage:(id)messageObject {
    [self.wormhole passMessageObject:messageObject identifier:@"toDoListItems"];
}

- (void)saveToUserDefaults:(id)object {
    [self.userDefaults setObject:object forKey:@"toDoListItems"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
