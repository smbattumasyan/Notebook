//
//  FoldersModel.h
//  Notebook
//
//  Created by Smbat Tumasyan on 1/26/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBCoreDataManager.h"
#import "Note.h"

@interface FoldersModel : NSObject

@property (nonnull, strong, nonatomic ) NBCoreDataManager          *coreDataManager;
@property (nonnull, strong, nonatomic ) NSFetchedResultsController *fetchedResultsController;

#pragma marik - Instance Methods

- (void)deleteFolder:(nonnull Folder *)managedObject;

- (nullable Folder *)addFolder:(nullable NSDictionary *)details;

@end
