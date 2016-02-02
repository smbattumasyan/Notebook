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

@interface NotesViewController () <UISearchBarDelegate, UITableViewDelegate>

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *notesSearchBar;

//------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//------------------------------------------------------------------------------------------
@property (assign, nonatomic) BOOL isAddButtonPressed;

@end

@implementation NotesViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadData];
    [self.dataController initFetchResultControler];
    self.navigationItem.title = NSLocalizedString(@"notebook", @"notes title");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)addButtonAction:(UIBarButtonItem *)sender
{
    self.isAddButtonPressed = YES;
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------------------

- (void)setupTableView
{
    self.tableView.dataSource = self.dataController;
    self.dataController.tableView = self.tableView;
}

-(void)loadData
{
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"folder == %@",self.folder];
    [self.dataController.notesModel fetchedResultsControllerWithPredicate:predicate];
    self.notesSearchBar.delegate                      = self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - Search Bar
//-------------------------------------------------------------------------------------------

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *predicate = nil;
    NSError *error         = nil;

    if (searchText.length > 0){
        predicate =[NSPredicate predicateWithFormat:@"name contains[cd] %@ and folder == %@", searchText, self.folder];
    }
    else {
        predicate =[NSPredicate predicateWithFormat:@"folder == %@",self.folder];
    }
    
    [self.dataController.notesModel.fetchedResultsController.fetchRequest setPredicate:predicate];

    if (![[self.dataController.notesModel fetchedResultsController] performFetch:&error]) {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterContentForSearchText:self.notesSearchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:self.notesSearchBar.text];
}

//------------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath           = [self.tableView indexPathForSelectedRow];
    NoteDetailsViewController *listDetailsVC = [segue destinationViewController];
    listDetailsVC.dataController             = self.dataController;

    if (self.isAddButtonPressed) {
        listDetailsVC.aFolder            = self.folder;
        listDetailsVC.isAddButtonPressed = YES;
        self.isAddButtonPressed          = NO;
    } else if ([[segue identifier] isEqualToString:@"NotesViewController"]) {
        listDetailsVC.aNote = [self.dataController.notesModel.fetchedResultsController objectAtIndexPath:selectedIndexPath];
    }
}

@end
