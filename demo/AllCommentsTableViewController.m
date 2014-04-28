//
//  AllCommentsTableViewController.m
//  demo
//
//  Created by 聂 路明 on 14-4-22.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import "AllCommentsTableViewController.h"
#import "NetWorkApi.h"
#import "Comment.h"
#import "CustomCommentTableViewCell.h"

@interface AllCommentsTableViewController ()

@property NSMutableArray* commentList;

@end

@implementation AllCommentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commentList = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCommentTableCell"
											   bundle:nil]
		 forCellReuseIdentifier:@"CustomCommentTableViewCell"];
    
    //int testUserId = self.userIdComment;
    [NetWorkApi getComments:self.userIdComment
                 completion:^(NSMutableArray *commentList) {
        self.commentList = commentList;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *c = [self.commentList objectAtIndex:indexPath.row];
    
    //need to be modified here:
    CustomCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCommentTableViewCell" forIndexPath:indexPath];
    
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCommentTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.commentContent.text = c.content;
    [NetWorkApi getUserInfo:(int)c.userID completion:^(User *user) {
		cell.commentPhoto.image = user.photo;
	}];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.commentList count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)unwindToAllComments:(UIStoryboardSegue *)segue {
	// uploadComment(int uid, int eid, int rating, NSString *comment);
}

@end
