//
//  CoreDataWrapper.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "CoreDataWrapper.h"

@implementation CoreDataWrapper

+ (nonnull instancetype)sharedInstance {
    
    static CoreDataWrapper *instance;
    
    if (!instance) {
        instance = [[CoreDataWrapper alloc] init];
    }
    
    return instance;
}



- (BOOL)saveList{
    
    NSError *error = nil;
    
    BOOL status = [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"addList error: %@", error);
    }
    
    return status;
}

- (void)deleteList:(NSManagedObject *)list {
    [self.managedObjectContext deleteObject:list];
    [self saveList];
}

- (Entity *)createList {
    
    Entity *list = [NSEntityDescription insertNewObjectForEntityForName:@"Entity"
                                               inManagedObjectContext:self.managedObjectContext];
    
    return list;
}


- (nullable NSArray <Entity *> *)findAllList; {
    
    NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
    
    NSArray *result =  [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    
    if (error) {
        NSLog(@"findAllList error: %@", error);
    }
    
    return result;
}


@end
