//
//  FoldersViewController.h
//  Notebook
//
//  Created by Smbat Tumasyan on 1/13/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldersModel.h"

@class FoldersDataController;

@interface FoldersViewController : UIViewController

#pragma mark - Propertes
@property (strong, nonatomic ) FoldersDataController *dataController;

@end
