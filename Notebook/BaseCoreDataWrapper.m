//
//  BaseCoreDataWrapper.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "BaseCoreDataWrapper.h"
#import "AppDelegate.h"

@implementation BaseCoreDataWrapper

- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    return appDelegate.managedObjectContext;
    
}


- (NSManagedObjectModel *)managedObjectModel {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    return appDelegate.managedObjectModel;
    
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    return appDelegate.persistentStoreCoordinator;
    
}

@end
