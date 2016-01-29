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

@interface NotesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

#pragma mark - Propertes
@property (strong, nonatomic) Folder *folder;
@property (strong, nonatomic) NotesModel *notesModel;

@end
