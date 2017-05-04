//
//  ANNewsChatCell.m
//  Annotator
//
//  Created by Karan Satia on 8/26/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANNewsChatCell.h"

@implementation ANNewsChatCell

- (void)awakeFromNib {
    // Initialization code
    self.cellView.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.cellView.layer.borderWidth = 1;
    self.initials.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.initials.layer.borderWidth = 1;
    self.initials.layer.cornerRadius = 21;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
