//
//  NBCoreDataManager.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NBCoreDataManager.h"

@implementation NBCoreDataManager

+ (nonnull instancetype)sharedInstance {
    
    static NBCoreDataManager *instance;
    if (!instance) {
        instance = [[NBCoreDataManager alloc] init];
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

- (NBDataModel *)createList {
    
    NBDataModel *list = [NSEntityDescription insertNewObjectForEntityForName:@"NBDataModel"
                                               inManagedObjectContext:self.managedObjectContext];
    
    return list;
}


- (nullable NSArray <NBDataModel *> *)findAllList; {
    
    NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NBDataModel"];
    
    NSArray *result =  [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    
    if (error) {
        NSLog(@"findAllList error: %@", error);
    }
    
    return result;
}


@end
