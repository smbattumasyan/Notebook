//
//  NoteListViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NoteListViewController.h"
#import "ListDetailsViewController.h"
#import "NoteListViewCell.h"
#import "NBCoreDataManager.h"

@interface NoteListViewController ()

@property (nonatomic, strong) NSArray *nbModelAllDatas;
@property (nonatomic, strong) NBDataModel *nbData;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL isAddButtonPressed;


@property (nonatomic, strong) NBCoreDataManager *coreDataManager;

@end

@implementation NoteListViewController

- (void)viewWillAppear:(BOOL)animated {
    self.nbModelAllDatas = [self.coreDataManager requestAllObjects];
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
    [self performSegueWithIdentifier:@"NoteListViewController" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.nbModelAllDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"tableIdenfier";
    NoteListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil) {
        cell = [[NoteListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    self.nbData = self.nbModelAllDatas[indexPath.row] ;
    cell.titleLabel.text = self.nbData.title;
    cell.detailsLabel.text = self.nbData.details;
    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:self.nbData.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"NoteListViewController" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
     ListDetailsViewController *vc = [segue destinationViewController];
    if (self.isAddButtonPressed) {
        vc.isAddButtonPressed = YES;
        self.isAddButtonPressed = NO;
    } else if ([[segue identifier] isEqualToString:@"NoteListViewController"]) {
        vc.cellDetails = self.nbModelAllDatas[selectedIndexPath.row];
    }
}

@end
