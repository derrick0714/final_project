//
//  EventCustomCellTableViewCell.m
//  demo
//
//  Created by 聂 路明 on 14-4-4.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import "EventCustomCellTableViewCell.h"
//framework to manage the property for tabel cells
#import <QuartzCore/QuartzCore.h>

@implementation EventCustomCellTableViewCell

@synthesize title = _title;
@synthesize time = _time;
@synthesize location = _location;
@synthesize personalImage = _personalImage;
@synthesize numberOfApplicant = _numberOfApplicant;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.numberOfApplicant.layer.cornerRadius = 12.0;
        self.numberOfApplicant.layer.masksToBounds = YES;
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
