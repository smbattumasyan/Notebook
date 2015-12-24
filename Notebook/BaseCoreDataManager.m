//
//  BaseCoreDataManager.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "BaseCoreDataManager.h"
#import "AppDelegate.h"

@implementation BaseCoreDataManager

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
