//
//  NBCoreDataManager.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "BaseCoreDataManager.h"

@interface NBCoreDataManager : BaseCoreDataManager

+ (nonnull instancetype)sharedInstance;

- (BOOL)saveList;
- (void)deleteList:(nonnull NBDataModel *)list;
- (nonnull NBDataModel *)createList;
- (nullable NSArray <NBDataModel *> *)findAllList;

@end
