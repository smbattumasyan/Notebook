//
//  FoldersModel.m
//  Notebook
//
//  Created by Smbat Tumasyan on 1/26/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "FoldersModel.h"
#import "Folder.h"

@interface FoldersModel ()

@end

@implementation FoldersModel

- (void)deleteFolder:(Folder *)managedObject
{
    [self.coreDataManager.managedObjectContext deleteObject:managedObject];
    [self.coreDataManager saveContext];
}

- (nullable Folder *)addFolder:(nullable NSDictionary *)details
{
    Folder *aFolder = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    aFolder.name    = details[@"name"];
    aFolder.date    = [NSDate date];
    
    [self.coreDataManager saveContext];
    return aFolder;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request          = [NSFetchRequest fetchRequestWithEntityName:@"Folder"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending: NO];
    [request setSortDescriptors:@[sortDescriptor]];
    _fetchedResultsController        = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.coreDataManager.managedObjectContext
                                                                              sectionNameKeyPath:nil cacheName:nil];
    NSError *error                   = nil;
   
    if( ! [_fetchedResultsController performFetch: &error] ) {
        NSLog( @"Error Description: %@", [error userInfo] );
    }
    return _fetchedResultsController;
}



@end
