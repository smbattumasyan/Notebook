//
//  NotesDataController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 2/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "NotesDataController.h"
#import "NoteViewCell.h"

@implementation NotesDataController

//------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//------------------------------------------------------------------------------------------

+ (instancetype)createInstance
{
    NotesDataController *dataController = [[NotesDataController alloc] init];
    return dataController;
}

//------------------------------------------------------------------------------------------
#pragma mark - Table View Data Source
//------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.notesModel.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableIdenfier";
    NoteViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[NoteViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:tableIdentifier];
    }
    cell.note = [self.notesModel.fetchedResultsController objectAtIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notesModel deleteNote:[self.notesModel.fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark Private Methods
//------------------------------------------------------------------------------------------

- (void)initFetchResultControler
{
    self.notesModel.fetchedResultsController.delegate = self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - NSFetchedResultsControllerDelegate
//-------------------------------------------------------------------------------------------

- (void)controllerWillChangeContent: (NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSLog(@"type = %lu", (unsigned long)type);
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths: @[newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths: @[newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
    }
}



@end
