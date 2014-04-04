//
//  EventCustomCellTableViewCell.h
//  demo
//
//  Created by 聂 路明 on 14-4-4.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCustomCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UILabel *location;
@property (nonatomic, weak) IBOutlet UIImageView *personalImage;

@end
