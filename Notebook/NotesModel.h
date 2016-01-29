//
//  NotesModel.h
//  Notebook
//
//  Created by Smbat Tumasyan on 1/27/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBCoreDataManager.h"

@interface NotesModel : NSObject

@property (nonnull, strong, nonatomic ) NBCoreDataManager          *coreDataManager;
@property (nonnull, strong, nonatomic ) NSFetchedResultsController *fetchedResultsController;

#pragma marik - Instance Methods

- (void)deleteNote:(nonnull Note *)managedObject;
- (nullable Note *)addNote:( nullable NSDictionary *)details;
- (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate;


@end
