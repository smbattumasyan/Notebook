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

@interface NBCoreDataManager : NSObject<NSFetchedResultsControllerDelegate>

#pragma mark Properties
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonnull, nonatomic, strong, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonnull, nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nullable, nonatomic, retain         ) NSFetchedResultsController   *fetchedResultsController;

#pragma mark - Class methods
+ (nonnull instancetype)sharedManager;

#pragma marik - Instance Methods
- (void)deleteNote:(nonnull Note *)managedObject;
- (nonnull Note *)createNote;
- (BOOL)saveObject;
- (void)deleteFolder:(nonnull Folder *)managedObject;
- (nonnull Folder *)createFolder;


- (void)saveContext;
- (nullable NSFetchedResultsController *)fetchedResultsController:(nullable NSString *)entityName sortKey:(nullable NSString *)sortKey predicate:(nullable NSString *)predicateString;
@end
