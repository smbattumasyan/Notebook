//
//  NoteDetailsViewController.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteDetailsViewController : UIViewController

#pragma mark - Propertes
@property (strong, nonatomic) Note *aNote;
@property (assign, nonatomic) BOOL  isAddButtonPressed;

@end
