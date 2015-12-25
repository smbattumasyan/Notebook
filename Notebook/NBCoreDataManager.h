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
- (void)deleteObject:(nonnull Note *)managedObject;
- (nonnull Note *)createObject;
- (nullable NSArray <Note *> *)requestAllObjects;

@end
