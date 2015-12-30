//
//  NBCoreDataManager.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Note.h"

@interface NBCoreDataManager : NSObject

#pragma mark Properties
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonnull, nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark - Class methods
+ (nonnull instancetype)sharedManager;

#pragma marik - Instance Methods
- (void)deleteObject:(nonnull Note *)managedObject;
- (nullable NSArray <Note *> *)requestAllObjects;
- (nonnull Note *)createObject;
- (BOOL)saveObject;

- (void)saveContext;

@end
