//
//  ANListChatsCell.h
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ANListChatsCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
