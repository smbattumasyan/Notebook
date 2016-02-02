//
//  NotesViewController.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Folder.h"
#import "NotesModel.h"
#import "NotesDataController.h"

@interface NotesViewController : UIViewController

#pragma mark - Propertes
@property (strong, nonatomic) Folder *folder;
@property (strong, nonatomic) NotesDataController *dataController;

@end
