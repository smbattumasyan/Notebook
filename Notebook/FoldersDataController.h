//
//  FoldersTableViewDataSource.h
//  Notebook
//
//  Created by Smbat Tumasyan on 1/29/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoldersModel.h"


@interface FoldersDataController : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

#pragma mark - Propertes
@property (strong, nonatomic) FoldersModel *folderModel;
@property (strong, nonatomic) UITableView  *tableView;

#pragma mark - Class Methods
- (void)createFolder:(NSString *)folderName;
+ (instancetype)createInstance;
- (void)initFetchResultControler;

@end
