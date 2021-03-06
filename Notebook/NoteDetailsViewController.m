//
//  NoteDetailsViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NoteDetailsViewController.h"
#import "NBCoreDataManager.h"

@interface NoteDetailsViewController ()

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic  ) IBOutlet UIBarButtonItem  *editButton;
@property (weak, nonatomic  ) IBOutlet UITextField      *titleTextField;
@property (weak, nonatomic  ) IBOutlet UITextView       *detailsTextView;
@property (weak, nonatomic  ) IBOutlet UIButton         *deleteButton;

//------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------------------


@end

@implementation NoteDetailsViewController

//------------------------------------------------------------------------------------------
#pragma mark - Lifecycle
//------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self loadData];
    [self setIBOutlets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)deleteButtonAction:(id)sender
{
    
    UIAlertController *deleteButtonAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Delete", @"delete alert title")
                                                                                message:NSLocalizedString(@"deleteMessage", @"note delete message") preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"yes", @"delete note alert yes button name")
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action)
                                            {
                                             [self.dataController.notesModel deleteNote:self.aNote];
                                             [deleteButtonAlert dismissViewControllerAnimated:YES completion:nil];
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }];
    UIAlertAction* noButton  = [UIAlertAction
                                            actionWithTitle:NSLocalizedString(@"no", @"delete note alert no button name")
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                            [deleteButtonAlert dismissViewControllerAnimated:YES  completion:nil];

                                            }];
    [deleteButtonAlert addAction:noButton];
    [deleteButtonAlert addAction:yesButton];
    [self presentViewController:deleteButtonAlert animated:YES completion:nil];
}

- (IBAction)editButtonAction:(UIBarButtonItem *)sender
{
    if (!self.titleTextField.enabled) {
        [self setTextViewEditable:YES];
        sender.title = NSLocalizedString(@"done", @"note done button name");
    } else {
        if (self.isAddButtonPressed) {
            [self createNote];
        }else {
            [self saveChangedValue];
        }

        [self setTextViewEditable:YES];
        sender.title = NSLocalizedString(@"edit", @"note editing button name");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark Privete Methods
//------------------------------------------------------------------------------------------

- (void)setIBOutlets
{

    [self setTextViewEditable:self.isAddButtonPressed];
    if (self.isAddButtonPressed) {
        self.editButton.title     = NSLocalizedString(@"done", @"note done button name")
        ;
        self.titleTextField.text  = NSLocalizedString(@"newTitle", @"new title name example");
        self.detailsTextView.text = NSLocalizedString(@"newText", @"new text name example");
        self.deleteButton.hidden  = YES;
    } else {
        self.editButton.title     = NSLocalizedString(@"edit", @"note editing button name");
        self.titleTextField.text  = [self.aNote  name];
        self.detailsTextView.text = [self.aNote details];
        self.deleteButton.hidden  = NO;
    }
}

- (void)setTextViewEditable:(BOOL)status
{
    if (status) {
        
        [self.titleTextField setEnabled:YES];
        [self.detailsTextView setEditable:YES];
    } else {
        [self.titleTextField setEnabled:NO];
        [self.detailsTextView setEditable:NO];
    }
}

- (void)createNote
{    
    [self.dataController.notesModel addNote:@{@"name":self.titleTextField.text,
                                    @"details":self.detailsTextView.text,
                                    @"date": [NSDate date],
                                    @"folder": self.aFolder}];
}

- (void)saveChangedValue
{
    [self.aNote setValue:[self.titleTextField text] forKey:@"name"];
    [self.aNote setValue:[self.detailsTextView text] forKey:@"details"];
    [self.dataController.notesModel.coreDataManager saveContext];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
