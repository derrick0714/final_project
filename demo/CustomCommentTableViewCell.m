//
//  CustomCommentTableViewCell.m
//  demo
//
//  Created by 聂 路明 on 14-4-22.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import "CustomCommentTableViewCell.h"

@implementation CustomCommentTableViewCell

@synthesize commentPhoto = _commentPhoto;
@synthesize commentContent = _commentContent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
