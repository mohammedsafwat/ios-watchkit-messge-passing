//
//  ToDoListWatchKitTableRow.h
//  ToDoList
//
//  Created by Mohammed Safwat on 9/21/15.
//  Copyright (c) 2015 safwat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface ToDoListWatchKitTableRow : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *toDoListItemTitleLabel;

@end
