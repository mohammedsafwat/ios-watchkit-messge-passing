//
//  InterfaceController.m
//  ToDoList WatchKit Extension
//
//  Created by Mohammed Safwat on 9/20/15.
//  Copyright (c) 2015 safwat. All rights reserved.
//

#import "InterfaceController.h"
#import "ToDoListWatchKitTableRow.h"
#import "MMWormhole.h"

@interface InterfaceController()
@property (nonatomic, strong) NSMutableArray* toDoListItems;
@property (nonatomic, strong) MMWormhole *wormhole;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.safwat.development.ToDoList" optionalDirectory:@"wormhole"];
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.safwat.development.ToDoList"];
}

- (void)loadTable {
    [self.toDoListInterfaceTable setNumberOfRows:self.toDoListItems.count withRowType:@"ToDoListWatchKitTableRow"];
    for(int i = 0; i < self.toDoListItems.count; i++) {
        ToDoListWatchKitTableRow* row = [self.toDoListInterfaceTable rowControllerAtIndex:i];
        row.toDoListItemTitleLabel.text = self.toDoListItems[i];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    // Using openParentapplication: method
    /*
    [WKInterfaceController openParentApplication:@{@"action":@"getToDoListItems"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if(error) {
            NSLog(@"An error happened while opening the parent application : %@", error.localizedDescription);
        }
        else {
            self.toDoListItems = [replyInfo valueForKey:@"toDoListItems"];
            [self loadTable];
        }
    }];
    */
    
    // Using MMWormhole method
    /*
    [self.wormhole listenForMessageWithIdentifier:@"toDoListItems" listener:^(id messageObject) {
        NSLog(@"messageObject %@", messageObject);
        self.toDoListItems = messageObject;
        [self loadTable];
    }];
     */
    
    // Using NSUserDefaults method
    self.toDoListItems = [self.userDefaults valueForKey:@"toDoListItems"];
    [self loadTable];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



