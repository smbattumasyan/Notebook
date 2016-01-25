//
//  FoldersViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 1/13/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "FoldersViewController.h"
#import "NBCoreDataManager.h"
#import "Folder.h"
#import "NotesViewController.h"

@interface FoldersViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------

@property (weak, nonatomic  ) IBOutlet UITableView *tableView;

//------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//------------------------------------------------------------------------------------------

@property (strong, nonatomic) NBCoreDataManager *coreDataManager;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation FoldersViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self loadData];
    self.title = NSLocalizedString(@"folders", @"Folders Title");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)newFolderAction:(UIButton *)sender {
    
    UIAlertController *addFolderAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"folder", "alert title") message:NSLocalizedString(@"folderMessage", "new folder message") preferredStyle:UIAlertControllerStyleAlert];
    [addFolderAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {

        textField.placeholder  = NSLocalizedString(@"folderName", @"textField text");
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"ok button name") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UITextField *textField = addFolderAlert.textFields[0];
            [self createFolder:textField.text];
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"cancel button name") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    }];
    [addFolderAlert addAction:cancelButton];
    [addFolderAlert addAction:okButton];
    [self presentViewController:addFolderAlert animated:YES completion:nil];
}

//------------------------------------------------------------------------------------------
#pragma mark - Table View Data Source
//------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"folderVCIdentifier";
    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    Folder *folder      = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",folder.name,folder.notes.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"FoldersViewController" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.coreDataManager deleteFolder:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark Privete Methods
//------------------------------------------------------------------------------------------

-(void)loadData {
    
   self.coreDataManager                   = [NBCoreDataManager sharedManager];
   self.fetchedResultsController          = [self.coreDataManager fetchedResultsController:FetchRequestEntityTypeFolder];
   self.fetchedResultsController.delegate = self;
}

- (void)createFolder:(NSString *)folderName {
    
    [self.coreDataManager addFolder:@{@"name":folderName,
                                      @"date":[NSDate date]}];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"FoldersViewController"]) {
        NotesViewController *noteViewController = [segue destinationViewController];
        noteViewController.folder               = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
    }
}

@end
