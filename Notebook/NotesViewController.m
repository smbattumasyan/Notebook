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

@interface NotesViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray           *sortedNotes;
@property (strong, nonatomic) Note              *aNote;
@property (assign, nonatomic) BOOL               isAddButtonPressed;
@property (strong, nonatomic) NBCoreDataManager *coreDataManager;

@end

@implementation NotesViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *notes   = [self.coreDataManager requestAllObjects];
    self.sortedNotes = [notes sortedArrayUsingComparator:
                                            ^(Note *obj1, Note *obj2) {
                                                return [obj2.date compare:obj1.date];
                                            }];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coreDataManager          = [NBCoreDataManager sharedManager];
    self.navigationItem.title     = @"Notebook";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)addButtonAction:(UIBarButtonItem *)sender {
    self.isAddButtonPressed = YES;
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - Table View Data Source
//------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedNotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"tableIdenfier";
    NoteViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell                         = [[NoteViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:tableIdentifier];
    }
    cell.note                        = self.sortedNotes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"NotesViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath            = [self.tableView indexPathForSelectedRow];
     NoteDetailsViewController *listDetailsVC = [segue destinationViewController];
    if (self.isAddButtonPressed) {
        listDetailsVC.isAddButtonPressed      = YES;
        self.isAddButtonPressed               = NO;
    } else if ([[segue identifier] isEqualToString:@"NotesViewController"]) {
        listDetailsVC.aNote                   = self.sortedNotes[selectedIndexPath.row];
    }
}

@end
