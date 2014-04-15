//
//  EventCandidatesCollectionViewController.m
//  demo
//
//  Created by Tom on 4/11/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "EventCandidatesCollectionViewController.h"
#import "CandidateCollectionViewCell.h"
#import "NetWorkApi.h"
#import "User.h"
#import "MeTableViewController.h"

@interface EventCandidatesCollectionViewController ()
@property NSMutableArray *candidates;
@end

@implementation EventCandidatesCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	//	[NetWorkApi candidatesByEventID:@"" completion:^(NSMutableArray *candidates)] {
//	self.candidates = [NSMutableArray arrayWithArray:@[@"Alice", @"Bob", @"Charlie", @"Dick"]];
	[NetWorkApi candidatesList:self.eventid completion:^(NSMutableArray *candidates) {
		self.candidates = [NSMutableArray arrayWithArray:candidates];
		NSLog(@"candidates: %@", self.candidates);
		[self.collectionView reloadData];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.candidates count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CandidateCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CandidateCell"
																					   forIndexPath:indexPath];
	User* u = [self.candidates objectAtIndex:indexPath.item];
	cell.nameLabel.text = u.userName;
	cell.image.image = u.photo;
	return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //click candidate picture to move to the candidate detail
	NSIndexPath *ip = [self.collectionView indexPathForCell:(UICollectionViewCell *)sender];
	User *u = [User initWithUser:(User *)[self.candidates objectAtIndex:ip.item]];
	MeTableViewController *destVC = (MeTableViewController *)[segue destinationViewController];
	destVC.userid = (int)u.userID;
	destVC.eventID = self.eventid;
	destVC.isApplicantToMe = self.isSelfEvent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
