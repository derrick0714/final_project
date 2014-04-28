//
//  CustomCommentTableViewCell.h
//  demo
//
//  Created by 聂 路明 on 14-4-22.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commentPhoto;
@property (weak, nonatomic) IBOutlet UITextView *commentContent;


@end
