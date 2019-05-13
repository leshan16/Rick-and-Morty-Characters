//
//  AADatabaseDetailViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseDetailViewController.h"
#import "AACharacterModel.h"
#import "AADatabaseTitleLabel.h"
#import "AADatabaseDetailTableView.h"
#import "AADatabaseDetailTableViewCell.h"

static const CGFloat AANavigationItemHeight = 65.0;
static const CGFloat AATabBarItemHeight = 50.0;


@interface AADatabaseDetailViewController () <UITableViewDataSource>

@property(nonatomic, nullable, strong) UIImageView *imageView;
@property(nonatomic, nullable, strong) AADatabaseTitleLabel *titleLabel;
@property(nonatomic, nullable, strong) AADatabaseDetailTableView *tableView;
@property(nonatomic, nullable, strong) NSMutableArray<NSArray *> *arrayFeatures;

@end


@implementation AADatabaseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.view.backgroundColor = UIColor.blackColor;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, AANavigationItemHeight, CGRectGetWidth(self.view.frame),
                                                                   CGRectGetWidth(self.view.frame))];
    self.imageView.backgroundColor = UIColor.whiteColor;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius  = self.imageView.frame.size.height / 20;
    self.imageView.image = self.characterInfo.image;
    [self.view addSubview:self.imageView];
    
    self.titleLabel = [[AADatabaseTitleLabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame),
                                                                             AATabBarItemHeight)];
    self.titleLabel.text = self.characterInfo.name;
    self.navigationItem.titleView = self.titleLabel;
    
    self.tableView = [[AADatabaseDetailTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame),
                                                                                 CGRectGetWidth(self.view.frame),
                                                                                 CGRectGetHeight(self.view.frame) -
                                                                                 CGRectGetMaxY(self.imageView.frame) -
                                                                                 AATabBarItemHeight)
                                                                style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.arrayFeatures = [NSMutableArray new];
    [self.arrayFeatures addObject:@[@"NAME:", self.characterInfo.name]];
    [self.arrayFeatures addObject:@[@"STATUS:", self.characterInfo.status]];
    [self.arrayFeatures addObject:@[@"SPECIES:", self.characterInfo.species]];
    [self.arrayFeatures addObject:@[@"TYPE:", self.characterInfo.type]];
    [self.arrayFeatures addObject:@[@"GENDER:", self.characterInfo.gender]];
    [self.arrayFeatures addObject:@[@"ORIGIN:", self.characterInfo.origin]];
    [self.arrayFeatures addObject:@[@"LOCATION:", self.characterInfo.location]];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayFeatures.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AADatabaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass
                                           ([AADatabaseDetailTableViewCell class]) forIndexPath:indexPath];
    cell.leftLabel.text = self.arrayFeatures[indexPath.row][0];
    cell.rightLabel.text = self.arrayFeatures[indexPath.row][1];
    
    return cell;
}

@end
