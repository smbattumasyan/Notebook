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
#import "FoldersModel.h"
#import "NotesModel.h"
#import "FoldersDataController.h"

@interface FoldersViewController() <UITableViewDelegate>

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------
@property (weak, nonatomic ) IBOutlet UITableView *tableView;

@end

@implementation FoldersViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];  
    
    [self setupTableView];
    [self.dataController initFetchResultControler];
    self.title = NSLocalizedString(@"folders", @"Folders Title");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [self performSegueWithIdentifier:@"FoldersViewController" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)newFolderAction:(UIButton *)sender
{
    
    UIAlertController *addFolderAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"folder", "alert title") message:NSLocalizedString(@"folderMessage", "new folder message") preferredStyle:UIAlertControllerStyleAlert];
    [addFolderAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {

        textField.placeholder  = NSLocalizedString(@"folderName", @"textField text");
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"ok button name") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UITextField *textField = addFolderAlert.textFields[0];
            [self.dataController createFolder:textField.text];
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"cancel button name") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    }];
    [addFolderAlert addAction:cancelButton];
    [addFolderAlert addAction:okButton];
    [self presentViewController:addFolderAlert animated:YES completion:nil];
}

//------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------------------

- (void)setupTableView
{
    self.tableView.dataSource = self.dataController;
    self.dataController.tableView = self.tableView;
}

//------------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------------

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"FoldersViewController"]) {
        NotesViewController *notesViewController = [segue destinationViewController];
        NotesModel *notesModel             = [[NotesModel alloc] init];
        notesModel.coreDataManager         = self.dataController.folderModel.coreDataManager;
        notesViewController.folder         = [self.dataController.folderModel.fetchedResultsController objectAtIndexPath:selectedIndexPath];
        notesViewController.dataController = [NotesDataController createInstance];
        notesViewController.dataController.notesModel = notesModel;
    }
}

@end
