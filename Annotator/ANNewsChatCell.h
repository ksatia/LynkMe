//
//  ANNewsChatCell.h
//  Annotator
//
//  Created by Karan Satia on 8/26/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ANNewsChatCell : SWTableViewCell


@property (weak, nonatomic) IBOutlet UILabel *initials;
@property (weak, nonatomic) IBOutlet UILabel *linkMessage;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *linkTitle;



@end
