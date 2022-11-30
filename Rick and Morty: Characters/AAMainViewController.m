//
//  AAMainViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAMainViewController.h"
#import "AADataRepository.h"
#import "AADatabaseDetailViewController.h"
#import "AAMainCollectionViewCell.h"
#import "AACharacterModel.h"


static const CGFloat AACellSpacing = 1.0;
static const NSInteger AANumberOfCharactersInTotal = 493;


@interface AAMainViewController () <AADataRepositoryOutputProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, nullable, strong) UICollectionView *collectionView;
@property (nonatomic, nullable, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, nullable, strong) NSMutableArray<AACharacterModel *> *characters;
@property (nonatomic, nullable, strong) AADataRepository *dataRepository;
@property (nonatomic, assign) NSInteger pageNumber;

@end


@implementation AAMainViewController

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_dataRepository = [AADataRepository new];
		_dataRepository.output = self;
		_pageNumber = 1;
		_characters = [NSMutableArray new];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
	[self.activityIndicator startAnimating];
	[self.dataRepository getCharactersInfoForPage:self.pageNumber];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	self.collectionView.frame = self.view.frame;
	self.activityIndicator.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
											  CGRectGetHeight(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
											  CGRectGetWidth(self.view.frame) / 4,
											  CGRectGetWidth(self.view.frame) / 4);
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.view.backgroundColor = UIColor.whiteColor;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"Rick and Morty: Characters";
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.textColor = UIColor.redColor;
    self.navigationItem.titleView = titleLabel;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = AACellSpacing;
    flowLayout.minimumInteritemSpacing = AACellSpacing;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) / 2 - AACellSpacing,
									 CGRectGetWidth(UIScreen.mainScreen.bounds) / 2 - AACellSpacing);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	self.collectionView.backgroundColor = UIColor.whiteColor;
	self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RickLayer"]];
	self.collectionView.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
	[self.collectionView registerClass:[AAMainCollectionViewCell class]
			forCellWithReuseIdentifier:NSStringFromClass([AAMainCollectionViewCell class])];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
	self.activityIndicator.color = UIColor.redColor;
	self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    [self.view addSubview:self.activityIndicator];
}


#pragma mark - AADataRepositoryOutputProtocol

- (void)didLoadPageWithCharactersInfo:(NSArray<AACharacterModel *> *)charactersInfo
{
	[self.characters addObjectsFromArray:charactersInfo];
    [self.collectionView reloadData];
	[self.activityIndicator stopAnimating];
	self.pageNumber++;
}

- (void)didRecieveErrorWithDescription:(NSString *)description
{
    [self.activityIndicator stopAnimating];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:description
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.characters.count - 1 &&
		self.characters.count <= AANumberOfCharactersInTotal &&
		!self.activityIndicator.isAnimating)
    {
        [self.activityIndicator startAnimating];
        [self.dataRepository getCharactersInfoForPage:self.pageNumber];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AADatabaseDetailViewController *detailViewController = [AADatabaseDetailViewController new];
    detailViewController.characterInfo = self.characters[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.characters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	AAMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AAMainCollectionViewCell class])
																				   forIndexPath:indexPath];
    cell.coverImageView.alpha = 0;
    cell.coverImageView.image = self.characters[indexPath.row].image;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.coverImageView.alpha = 1.0;
    } completion: nil];
    
    return cell;
}


@end
