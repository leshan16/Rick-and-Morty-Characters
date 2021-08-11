//
//  AADatabaseViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseViewController.h"
#import "AADataService.h"
#import "AADatabaseDetailViewController.h"
#import "AADatabaseCollectionViewCell.h"
#import "AACharacterModel.h"

static const CGFloat AACellSpacing = 1.0;
static const NSInteger AANumberOfCharactersInTotal = 493;


@interface AADatabaseViewController () <AADataServiceOutputProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, nullable, strong) UILabel *titleLabel;
@property (nonatomic, nullable, strong) UICollectionView *collectionView;
@property (nonatomic, nullable, strong) AADataService *dataService;
@property (nonatomic, nullable, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, nullable, strong) NSMutableArray<AACharacterModel *> *arrayCharacters;

@end


@implementation AADatabaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.view.backgroundColor = UIColor.whiteColor;

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50)];
    self.titleLabel.text = @"Rick and Morty: Characters";
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.textColor = UIColor.redColor;

    self.navigationItem.titleView = self.titleLabel;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = AACellSpacing;
    flowLayout.minimumInteritemSpacing = AACellSpacing;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - AACellSpacing, CGRectGetWidth(self.view.frame) / 2);

	CGRect collectionViewFrame = CGRectMake(0, AACellSpacing, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - AACellSpacing);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
	self.collectionView.backgroundColor = UIColor.whiteColor;
	self.collectionView.layer.contents = (id)[UIImage imageNamed:@"RickLayer"].CGImage;
	[self.collectionView registerClass:[AADatabaseCollectionViewCell class]
			forCellWithReuseIdentifier:NSStringFromClass([AADatabaseCollectionViewCell class])];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
                                                       CGRectGetHeight(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
                                                       CGRectGetWidth(self.view.frame) / 4, CGRectGetWidth(self.view.frame) / 4)];
	self.activityIndicator.color = UIColor.redColor;
	self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    self.arrayCharacters = [NSMutableArray new];
    self.dataService = [AADataService new];
    self.dataService.output = self;
    [self.dataService getCharactersInfo];
}


#pragma mark - AADataServiceOutputProtocol

- (void)addNewPage:(NSMutableArray *)charactersInfo
{
    for (AACharacterModel *character in charactersInfo)
    {
        [self.arrayCharacters addObject:character];
    }
    [self.activityIndicator stopAnimating];
    [self.collectionView reloadData];
}


- (void)showAlert:(NSString *)textAlert
{
    [self.activityIndicator stopAnimating];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:textAlert
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.arrayCharacters.count - 1 && self.arrayCharacters.count <= AANumberOfCharactersInTotal)
    {
        [self.activityIndicator startAnimating];
        [self.dataService getCharactersInfo];
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AADatabaseDetailViewController *detailViewController = [AADatabaseDetailViewController new];
    detailViewController.characterInfo = self.arrayCharacters[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayCharacters.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AADatabaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass
                                          ([AADatabaseCollectionViewCell class])
                                                                                   forIndexPath:indexPath];
    cell.coverImageView.alpha = 0;
    cell.coverImageView.image = self.arrayCharacters[indexPath.row].image;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.coverImageView.alpha = 1.0;
    } completion: nil];
    
    return cell;
}

@end
