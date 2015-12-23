//
//  CoreDataWrapper.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/23/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "BaseCoreDataWrapper.h"

@interface CoreDataWrapper : BaseCoreDataWrapper

+ (nonnull instancetype)sharedInstance;

- (BOOL)saveList;
- (void)deleteList:(nonnull Entity *)list;
- (nonnull Entity *)createList;
- (nullable NSArray <Entity *> *)findAllList;

@end
