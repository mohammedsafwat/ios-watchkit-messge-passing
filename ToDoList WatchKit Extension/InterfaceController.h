//
//  InterfaceController.h
//  ToDoList WatchKit Extension
//
//  Created by Mohammed Safwat on 9/20/15.
//  Copyright (c) 2015 safwat. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceTable *toDoListInterfaceTable;

@end
