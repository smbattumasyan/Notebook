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

@interface FoldersViewController ()

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------
@property (weak, nonatomic  ) IBOutlet UITableView *tableView;

//------------------------------------------------------------------------------------------
#pragma mark - Private Properties
//------------------------------------------------------------------------------------------

@property (strong, nonatomic) NBCoreDataManager *coreDataManager;

@end

@implementation FoldersViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.coreDataManager                          = [NBCoreDataManager sharedManager];
    [self setFetchedResultsController:@"Folder" sortKey:@"date" predicate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"folders", @"Folders Title");
}

- (void)viewDidUnload {
    
    self.coreDataManager.fetchedResultsController = nil;
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
        if ([self checkFolders:textField.text]) {
            addFolderAlert.message = NSLocalizedString(@"nameExist", @"exist name message");
            [self presentViewController:addFolderAlert animated:YES completion:nil];
        } else {
            [self createFolder:textField.text];
            [self.tableView reloadData];
        }
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"cancel button name") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

    }];
    [addFolderAlert addAction:okButton];
    [addFolderAlert addAction:cancelButton];
    [self presentViewController:addFolderAlert animated:YES completion:nil];
}


//------------------------------------------------------------------------------------------
#pragma mark - Table View Data Source
//------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.coreDataManager.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"folderVCIdentifier";
    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    Folder *folder      = [[self.coreDataManager fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = folder.folderName;
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
        Folder *folder       = [[self.coreDataManager fetchedResultsController] objectAtIndexPath:indexPath];
        NSString *folderName = folder.folderName;
        [self.coreDataManager deleteFolder:[[self.coreDataManager fetchedResultsController] objectAtIndexPath:indexPath]];
        NSError *error       = nil;
        if (![self.coreDataManager.fetchedResultsController performFetch:&error]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self setFetchedResultsController:@"Note" sortKey:@"date" predicate:folderName];
        for (Note *note in [self.coreDataManager.fetchedResultsController fetchedObjects]) {
            [self.coreDataManager deleteNote:note];
        }
        [self setFetchedResultsController:@"Folder" sortKey:@"date" predicate:nil];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark Privete Methods
//------------------------------------------------------------------------------------------

-(BOOL)checkFolders:(NSString *)folderName {
    
    [self setFetchedResultsController:@"Folder" sortKey:@"date" predicate:folderName];
    if ([[self.coreDataManager.fetchedResultsController fetchedObjects] count] > 0) {
        return YES;
    }
    return NO;
}

-(void)setFetchedResultsController:(NSString *)entityName sortKey:(NSString *)sortKey predicate:(NSString *)predicate {
    
    self.coreDataManager.fetchedResultsController = nil;
    [self.coreDataManager fetchedResultsController:entityName sortKey:sortKey predicate:predicate];
    NSError *error                                = nil;
    if (![self.coreDataManager.fetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
}

- (void)createFolder:(NSString *)folderName {
    
    Folder *folder    = [self.coreDataManager createFolder];
    folder.folderName = folderName;
    folder.date       = [NSDate date];
    [self.coreDataManager saveObject];
    [self setFetchedResultsController:@"Folder" sortKey:@"date" predicate:nil];
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
        NotesViewController *noteViewController       = [segue destinationViewController];
        noteViewController.folder                     = [[self.coreDataManager fetchedResultsController] objectAtIndexPath:selectedIndexPath];
    }
}


@end
