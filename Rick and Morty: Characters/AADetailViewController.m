//
//  AADetailViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADetailViewController.h"
#import "AACharacterModel.h"
#import "AADetailTableViewCell.h"
#import "AADetailTableViewModel.h"


@interface AADetailViewController () <UITableViewDataSource>

@property(nonatomic, nullable, strong) UIImageView *imageView;
@property(nonatomic, nullable, strong) UITableView *tableView;
@property(nonatomic, nullable, strong) NSArray<AADetailTableViewModel *> *features;

@end


@implementation AADetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];

	self.features = @[
		[[AADetailTableViewModel alloc] initWithName:@"NAME:" value:self.characterInfo.name],
		[[AADetailTableViewModel alloc] initWithName:@"STATUS:" value:self.characterInfo.status],
		[[AADetailTableViewModel alloc] initWithName:@"SPECIES:" value:self.characterInfo.species],
		[[AADetailTableViewModel alloc] initWithName:@"TYPE:" value:self.characterInfo.type],
		[[AADetailTableViewModel alloc] initWithName:@"GENDER:" value:self.characterInfo.gender],
		[[AADetailTableViewModel alloc] initWithName:@"ORIGIN:" value:self.characterInfo.origin],
		[[AADetailTableViewModel alloc] initWithName:@"LOCATION:" value:self.characterInfo.location]
	];
	[self.tableView reloadData];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	self.imageView.frame = CGRectMake(0, self.view.safeAreaInsets.top, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame));
	self.imageView.layer.cornerRadius  = self.imageView.frame.size.height / 20;

	CGFloat tableViewHeight = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.imageView.frame) - self.view.safeAreaInsets.bottom;
	CGRect tableViewFrame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.view.frame), tableViewHeight);
	self.tableView.frame = tableViewFrame;
	self.tableView.rowHeight = tableViewHeight / 4;
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.view.backgroundColor = UIColor.whiteColor;

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.backgroundColor = UIColor.whiteColor;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.image = self.characterInfo.image;
    [self.view addSubview:self.imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = self.characterInfo.name;
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.textColor = UIColor.redColor;
    self.navigationItem.titleView = titleLabel;

	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.tableView.backgroundColor = UIColor.whiteColor;
	[self.tableView registerClass:[AADetailTableViewCell class]
		   forCellReuseIdentifier:NSStringFromClass([AADetailTableViewCell class])];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.features.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AADetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AADetailTableViewCell class])
																  forIndexPath:indexPath];
    cell.nameLabel.text = self.features[indexPath.row].name;
    cell.valueLabel.text = self.features[indexPath.row].value;
    
    return cell;
}

@end
