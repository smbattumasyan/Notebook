//
//  ListDetailsViewController.h
//  Notebook
//
//  Created by Smbat Tumasyan on 12/22/15.
//  Copyright © 2015 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBDataModel.h"

@interface ListDetailsViewController : UIViewController

@property (nonatomic, strong) NBDataModel *listDetails;
@property (nonatomic, assign) BOOL isAddButtonPressed;

@end
