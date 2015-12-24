//
//  NBListsViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NBListsViewController.h"
#import "ListDetailsViewController.h"
#import "NoteListViewCell.h"
#import "NBCoreDataManager.h"

@interface NBListsViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL isAddButtonPressed;
@property (nonatomic, strong) NSArray *allModelDates;
@property (nonatomic, strong) NBDataModel *modelData;

@property (nonatomic, strong) NBCoreDataManager *coreDataManager;

@end

@implementation NBListsViewController

- (void)viewWillAppear:(BOOL)animated {
    self.allModelDates = [self.coreDataManager requestAllObjects];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Notebook";
    self.coreDataManager = [NBCoreDataManager sharedManager];
}
- (IBAction)addButtonAction:(UIBarButtonItem *)sender {
    self.isAddButtonPressed = YES;
    [self performSegueWithIdentifier:@"NBListsViewController" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allModelDates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"tableIdenfier";
    NoteListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[NoteListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    self.modelData = self.allModelDates[indexPath.row] ;
    cell.titleLabel.text = [self.modelData title];
    cell.detailsLabel.text = [self.modelData details];
    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:self.modelData.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"NBListsViewController" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
     ListDetailsViewController *listDetailsVC = [segue destinationViewController];
    if (self.isAddButtonPressed) {
        listDetailsVC.isAddButtonPressed = YES;
        self.isAddButtonPressed = NO;
    } else if ([[segue identifier] isEqualToString:@"NBListsViewController"]) {
        listDetailsVC.detailsData = self.allModelDates[selectedIndexPath.row];
    }
}

@end
