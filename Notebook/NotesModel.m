//
//  NotesModel.m
//  Notebook
//
//  Created by Smbat Tumasyan on 1/27/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "NotesModel.h"

@implementation NotesModel

- (void)deleteNote:(Note *)managedObject
{
    
    [self.coreDataManager.managedObjectContext deleteObject:managedObject];
    [self.coreDataManager saveContext];
}

- (Note *)addNote:( nullable NSDictionary *)details
{
    Note *aNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                inManagedObjectContext:self.coreDataManager.managedObjectContext];
    aNote.name = details[@"name"];
    aNote.details = details[@"details"];
    aNote.date = details[@"date"];
    aNote.folder = details[@"folder"];
    [self.coreDataManager saveContext];
    
    return aNote;
}

- (NSFetchedResultsController *)fetchedResultsControllerWithPredicate:(NSPredicate *)predicate
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }   
    
    NSFetchRequest *request          = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending: NO];
    if (predicate) {
        [request setPredicate:predicate];
    }
    [request setSortDescriptors: @[sortDescriptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.coreDataManager.managedObjectContext
                                                                              sectionNameKeyPath:nil cacheName:nil];
    NSError *error            = nil;
    if( ! [_fetchedResultsController performFetch: &error] ) {
        NSLog( @"Error Description: %@", [error userInfo] );
    }
    return _fetchedResultsController;
}

@end
