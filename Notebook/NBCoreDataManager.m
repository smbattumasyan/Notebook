//
//  NBCoreDataManager.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NBCoreDataManager.h"

@implementation NBCoreDataManager

#pragma mark - Shared Manager
+ (nonnull instancetype)sharedManager {
    
    static NBCoreDataManager *instance;
    if (!instance) {
        instance = [[NBCoreDataManager alloc] init];
    }
    
    return instance;
}

#pragma mark - Data Managers
- (BOOL)saveObject{
    
    NSError *error = nil;
    BOOL status = [self.managedObjectContext save:&error];    
    if (error) {
        NSLog(@"addList error: %@", error);
    }
    
    return status;
}

- (void)deleteObject:(Note *)managedObject {
    [self.managedObjectContext deleteObject:managedObject];
    [self saveObject];
}

- (Note *)createObject {
    
    Note *list = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:self.managedObjectContext];
    return list;
}


- (nullable NSArray <Note *> *)requestAllObjects; {
    
    NSError *error = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    NSArray *result =  [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    if (error) {
        NSLog(@"requestAllObjects error: %@", error);
    }
    return result;
}


@end
