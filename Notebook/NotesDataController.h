//
//  NotesDataController.h
//  Notebook
//
//  Created by Smbat Tumasyan on 2/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NotesModel.h"

@interface NotesDataController : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

#pragma mark - Propertes
@property (strong, nonatomic) NotesModel  *notesModel;
@property (strong, nonatomic) UITableView *tableView;

#pragma mark - Class Methods
+ (instancetype)createInstance;
- (void)initFetchResultControler;

@end
