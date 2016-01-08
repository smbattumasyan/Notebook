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

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem  *editButton;
@property (weak, nonatomic) IBOutlet UITextField      *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView       *detailsTextView;
@property (weak, nonatomic) IBOutlet UIButton         *deleteButton;

@property (strong, nonatomic) NBCoreDataManager *coreDataManager;

@end

@implementation NoteDetailsViewController

//------------------------------------------------------------------------------------------
#pragma mark - Lifecycle
//------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coreDataManager = [NBCoreDataManager sharedManager];
    [self setIBOutlets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------------------
#pragma mark - IBActions
//------------------------------------------------------------------------------------------

- (IBAction)deleteButtonAction:(id)sender {
    UIAlertController *deleteButtonAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Delete", nil)
                                                                                message:NSLocalizedString(@"deleteMessage", nil) preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesButton             = [UIAlertAction actionWithTitle:NSLocalizedString(@"yes", nil)
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action)
                                            {
                                             [self.coreDataManager deleteObject:self.aNote];
                                             [self.coreDataManager saveObject];
                                             [deleteButtonAlert dismissViewControllerAnimated:YES completion:nil];
                                                [self.navigationController popViewControllerAnimated:YES];
                                                                      
                                            }];
    UIAlertAction* noButton              = [UIAlertAction
                                            actionWithTitle:NSLocalizedString(@"no", nil)
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                            [deleteButtonAlert dismissViewControllerAnimated:YES  completion:nil];
                                       
                                            }];
    [deleteButtonAlert addAction:noButton];
    [deleteButtonAlert addAction:yesButton];
    [self presentViewController:deleteButtonAlert animated:YES completion:nil];
}

- (IBAction)editButtonAction:(UIBarButtonItem *)sender {
    
    if (!self.titleTextField.enabled) {
        [self setTextViewEditable:YES];
        sender.title        = NSLocalizedString(@"done", nil);
    } else {
        if (self.isAddButtonPressed) {
            Note *newNote   = [self.coreDataManager createObject];
            newNote.title   = [self.titleTextField text];
            newNote.details = [self.detailsTextView text];
            newNote.date    = [NSDate date];
            [self.coreDataManager saveObject];
        }
        [self.aNote setValue:[self.titleTextField text] forKey:@"title"];
        [self.aNote setValue:[self.detailsTextView text] forKey:@"details"];
        [self.coreDataManager saveObject];
        [self setTextViewEditable:YES];
        sender.title        = NSLocalizedString(@"edit", nil);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//------------------------------------------------------------------------------------------
#pragma mark Privete Methods
//------------------------------------------------------------------------------------------

- (void)setIBOutlets {
    if (_isAddButtonPressed) {
        [self setTextViewEditable:self.isAddButtonPressed];
        self.editButton.title     = NSLocalizedString(@"done", nil)
        ;
        self.titleTextField.text  = NSLocalizedString(@"newTitle", nil);
        self.detailsTextView.text = NSLocalizedString(@"newText", nil);
        self.deleteButton.hidden  = YES;
    } else {
        [self setTextViewEditable:self.isAddButtonPressed];
        self.editButton.title     = NSLocalizedString(@"edit", nil);
        self.titleTextField.text  = [self.aNote title];
        self.detailsTextView.text = [self.aNote details];
        self.deleteButton.hidden  = NO;
    }
}

- (void)setTextViewEditable:(BOOL)status {
    if (status) {
        [self.titleTextField setEnabled:YES];
        [self.detailsTextView setEditable:YES];
    } else {
        [self.titleTextField setEnabled:NO];
        [self.detailsTextView setEditable:NO];
    }
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
