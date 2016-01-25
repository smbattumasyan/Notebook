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
#import "Folder.h"

typedef NS_ENUM (NSInteger, FetchRequestEntityType) {
    /**
     *  Fetch request for not specified entity
     */
    FetchRequestEntityTypeNone,
    /**
     *  Fetch request for Note entity
     */
    FetchRequestEntityTypeNote,
    /**
     *  Fetch request for Folder entity
     */
    FetchRequestEntityTypeFolder,
};

@interface NBCoreDataManager : NSObject

#pragma mark Properties
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonnull, nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nullable, nonatomic, retain         ) NSFetchedResultsController   *fetchedResultsController;

#pragma mark - Class methods
+ (nonnull instancetype)sharedManager;

#pragma marik - Instance Methods
- (void)deleteNote:(nonnull Note *)managedObject;
- (nonnull Note *)addNote:(nullable NSDictionary *)details;
- (BOOL)saveObject;
- (void)deleteFolder:(nonnull Folder *)managedObject;

- (nullable NSFetchedResultsController *)fetchedResultsController:(FetchRequestEntityType)entity;
- (nullable NSFetchedResultsController *)fetchedResultsControllerFor: (nonnull Folder *)folder;

- (void)saveContext;

- (nullable Folder *)addFolder:(nullable NSDictionary *)details;

@end
