//
//  NotesViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NotesViewController.h"
#import "NoteDetailsViewController.h"
#import "NoteViewCell.h"
#import "NBCoreDataManager.h"

@interface NotesViewController () <NSFetchedResultsControllerDelegate>

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------
@property (weak, nonatomic  ) IBOutlet UITableView *tableView;

//------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//------------------------------------------------------------------------------------------
@property (assign, nonatomic) BOOL              isAddButtonPressed;
@property (strong, nonatomic) NBCoreDataManager *coreDataManager;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NotesViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    self.navigationItem.title = NSLocalizedString(@"notebook", @"notes title");
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)addButtonAction:(UIBarButtonItem *)sender{
    
    self.isAddButtonPressed = YES;
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - Table View Data Source
//------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"tableIdenfier";
    NoteViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[NoteViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:tableIdentifier];
    }
    cell.note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.coreDataManager deleteNote:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
  //      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------------------

-(void)loadData {
    
    self.coreDataManager                   = [NBCoreDataManager sharedManager];
    self.fetchedResultsController          = [self.coreDataManager fetchedResultsControllerFor:self.folder];
    self.fetchedResultsController.delegate = self;
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


//------------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedIndexPath           = [self.tableView indexPathForSelectedRow];
    NoteDetailsViewController *listDetailsVC = [segue destinationViewController];
    if (self.isAddButtonPressed) {
        listDetailsVC.aFolder = self.folder;
        listDetailsVC.isAddButtonPressed = YES;
        self.isAddButtonPressed          = NO;
    } else if ([[segue identifier] isEqualToString:@"NotesViewController"]) {
        listDetailsVC.aNote = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
    }
}

@end
