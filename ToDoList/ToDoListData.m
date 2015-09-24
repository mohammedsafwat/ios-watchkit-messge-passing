//
//  ToDoListData.m
//  ToDoList
//
//  Created by Mohammed Safwat on 9/21/15.
//  Copyright (c) 2015 safwat. All rights reserved.
//

#import "ToDoListData.h"

@interface ToDoListData()
@property (nonatomic, strong) NSMutableArray* toDoListItems;
@end

@implementation ToDoListData

+ (ToDoListData *) sharedInstance
{
    static dispatch_once_t onceToken;
    static ToDoListData *singelton = nil;
    dispatch_once(&onceToken, ^{
        singelton = [[ToDoListData alloc] init];
    });
    return singelton;
}

- (id)init {
    self = [super init];
    if(self){
        self.toDoListItems = [NSMutableArray array];
        [self.toDoListItems addObject:@"This is a default to-do."];
    }
    return self;
}

+ (NSMutableArray*)toDoListItems {
    return [self sharedInstance].toDoListItems;
}

@end
