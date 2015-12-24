//
//  ListDetailsViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "ListDetailsViewController.h"
#import "NBCoreDataManager.h"

@interface ListDetailsViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (nonatomic, strong) NBCoreDataManager *coreDataManager;

@end

@implementation ListDetailsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coreDataManager = [NBCoreDataManager sharedManager];
    if (self.isAddButtonPressed) {
        [self.titleTextField setEnabled:YES];
        [self.detailsTextView setEditable:YES];
        self.editButton.title = @"Done";
        self.navigationItem.title = [NSDateFormatter localizedStringFromDate:[NSDate date]dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
        self.titleTextField.text = @"New Title";
        self.detailsTextView.text = @"New Text";
        
    } else {
        [self.titleTextField setEnabled:NO];
        [self.detailsTextView setEditable:NO];
        self.editButton.title = @"Edit";
        self.titleTextField.text = self.cellDetails.title;
        self.detailsTextView.text = self.cellDetails.details;
        self.navigationItem.title = [NSDateFormatter localizedStringFromDate:self.cellDetails.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    }
    
}

- (IBAction)deleteButtonAction:(id)sender {
    [self.coreDataManager deleteObject:self.cellDetails];
    [self.coreDataManager saveObject];
    UIAlertController * alertOfDeleteButton=   [UIAlertController
                                  alertControllerWithTitle:@"Delete"
                                  message:@"Successful deleted from memory"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [alertOfDeleteButton dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    [alertOfDeleteButton addAction:okButton];
    [self presentViewController:alertOfDeleteButton animated:YES completion:nil];
}

- (IBAction)editButtonAction:(UIBarButtonItem *)sender {
    
    if (self.titleTextField.enabled == NO) {
        [self.titleTextField setEnabled:YES];
        [self.detailsTextView setEditable:YES];
        sender.title = @"Done";
 
    } else {
        if (self.isAddButtonPressed) {
            NBDataModel *newEntity = [self.coreDataManager createObject];
            newEntity.title = self.titleTextField.text;
            newEntity.details = self.detailsTextView.text;
            newEntity.date = [NSDate date];
            [self.coreDataManager saveObject];
        }
        [self.cellDetails setValue:self.titleTextField.text forKey:@"title"];
        [self.cellDetails setValue:self.detailsTextView.text forKey:@"details"];
        [self.coreDataManager saveObject];
        [self.titleTextField setEnabled:NO];
        [self.detailsTextView setEditable:NO];
        sender.title = @"Edit";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
