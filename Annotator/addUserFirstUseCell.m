//
//  addUserFirstUseCell.m
//  Annotator
//
//  Created by Karan Satia on 8/28/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import "addUserFirstUseCell.h"

@implementation addUserFirstUseCell

- (void)awakeFromNib {
    self.cellView.layer.borderWidth = 1;
    self.friendsPicture.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.friendsPicture.layer.borderWidth = 1;
    self.friendsPicture.layer.cornerRadius = 21;
    self.friendsPicture.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.cellView.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.cellView.layer.borderWidth = 1;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
