//
//  NoteViewCell.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteViewCell : UITableViewCell

#pragma mark - Propertes
@property (nonatomic, strong) Note *note;

@end
