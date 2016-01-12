//
//  NoteViewCell.m
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import "NoteViewCell.h"

@interface NoteViewCell ()

//------------------------------------------------------------------------------------------
#pragma mark - IBOutlets
//------------------------------------------------------------------------------------------

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation NoteViewCell

//------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------------------

- (void)setNote:(Note *)note {
    _note                  = note;
    self.titleLabel.text   = [_note title];
    self.dateLabel.text    = [NSDateFormatter localizedStringFromDate:_note.date dateStyle:NSDateFormatterShortStyle timeStyle:
                              NSDateFormatterShortStyle];
    self.detailsLabel.text = [_note details];
}

@end
