//
//  NBCoreDataManager.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "BaseCoreDataManager.h"

@interface NBCoreDataManager : BaseCoreDataManager

+ (nonnull instancetype)sharedManager;

- (BOOL)saveObject;
- (void)deleteObject:(nonnull NBDataModel *)managedObject;
- (nonnull NBDataModel *)createObject;
- (nullable NSArray <NBDataModel *> *)requestAllObjects;

@end
