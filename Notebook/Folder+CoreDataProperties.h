//
//  Folder+CoreDataProperties.h
//  Notebook
//
//  Created by Smbat Tumasyan on 1/21/16.
//  Copyright © 2016 EGS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Folder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Folder (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *folderName;
@property (nullable, nonatomic, retain) NSSet<Note *> *notes;

@end

@interface Folder (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet<Note *> *)values;
- (void)removeNotes:(NSSet<Note *> *)values;

@end

NS_ASSUME_NONNULL_END
