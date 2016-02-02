//
//  IntroViewController.m
//  Notebook
//
//  Created by Smbat Tumasyan on 1/26/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "IntroViewController.h"
#import "FoldersModel.h"
#import "FoldersViewController.h"
#import "FoldersDataController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

//------------------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------------------

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSegueWithIdentifier:@"IntroViewController" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)openButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"IntroViewController" sender:self];
}

//------------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------------

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"IntroViewController"]) {
        
        FoldersViewController *foldersViewController = [segue destinationViewController];
        FoldersModel *foldersModel                   = [[FoldersModel alloc] init];
        foldersModel.coreDataManager                 = [NBCoreDataManager createInstance];

        foldersViewController.dataController             = [FoldersDataController createInstance];
        foldersViewController.dataController.folderModel = foldersModel;
    }
}

@end
