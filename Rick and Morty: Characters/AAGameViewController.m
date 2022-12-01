//
//  AAGameViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameViewController.h"
#import "AADataRepository.h"
#import "AAGameNumberGenerator.h"
#import "AAGameRootView.h"
#import "AACharacterModel.h"
#import "AAGameRootViewOutputProtocol.h"


@interface AAGameViewController () <AAGameRootViewOutputProtocol, AADataRepositoryOutputProtocol>

@property (nonatomic, nullable, strong) AAGameRootView *rootView;
@property (nonatomic, nullable, strong) AADataRepository *dataRepository;
@property (nonatomic, nullable, strong) id<AAGameNumberGeneratorProtocol> numberGenerator;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, nullable, strong) NSArray<AACharacterModel *> *characters;

@end


@implementation AAGameViewController

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_dataRepository = [AADataRepository new];
		_dataRepository.output = self;
		_numberGenerator = [AAGameNumberGenerator new];
		_score = 0;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
	[self getNewQuestion];
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.rootView = [[AAGameRootView alloc] initWithFrame:self.view.frame];
    self.rootView.output = self;
	NSString *textScore = [NSString stringWithFormat:@"Best: %ld", [[NSUserDefaults standardUserDefaults] integerForKey:@"BestScore"]];
    self.rootView.bestScoreLabel.text = textScore;
    [self.rootView installStartFrame];
    [self.view addSubview:self.rootView];
}


#pragma mark - Create new question

- (void)getNewQuestion
{
    NSArray<NSNumber *> *arraySearchID = [self.numberGenerator getRandomFourNumbers1to493FromDate:[NSDate date]];
    [self.rootView.activityIndicator startAnimating];
	[self.dataRepository getCharactersInfoForIds:arraySearchID];
}

- (void)showAlert:(NSString *)textAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:textAlert
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - AAGamePictureProtocol

- (void)pictureSelected:(NSInteger)selectedIndex
{
	NSInteger indexItem = 0;
    for (AAGamePicture *gamePicture in self.rootView.arrayPictures)
    {
        if ([self.characters[indexItem].name isEqualToString:self.rootView.questionLabel.text])
        {
            gamePicture.layer.borderColor = UIColor.greenColor.CGColor;
        }
        else
        {
            gamePicture.layer.borderColor = UIColor.redColor.CGColor;
        }
		indexItem++;
    }

    if (selectedIndex < self.characters.count && [self.characters[selectedIndex].name isEqualToString:self.rootView.questionLabel.text])
    {
        self.score++;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (self.score > [defaults integerForKey:@"BestScore"])
        {
            [defaults setInteger:self.score forKey:@"BestScore"];
            self.rootView.bestScoreLabel.text = [NSString stringWithFormat:@"Best: %ld", self.score];
        }
    }
    else
    {
        self.score = 0;
    }
    self.rootView.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.score];
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.rootView installStartFrame];
    } completion:nil];
    [self getNewQuestion];
}


#pragma mark - AADataRepositoryOutputProtocol

- (void)didRecieveErrorWithDescription:(nullable NSString *)description
{
	[self showAlert:description];
}

- (void)didLoadCharactersInfo:(nullable NSArray<AACharacterModel *> *)charactersInfo
{
	[self.rootView.activityIndicator stopAnimating];
	if (charactersInfo.count != 4)
	{
		[self showAlert:@"No internet connection"];
		return;
	}
	NSInteger indexItem = 0;
	self.characters = charactersInfo;

	for (AACharacterModel *item in charactersInfo)
	{
		self.rootView.arrayPictures[indexItem].image = item.image;
		indexItem++;
	}

	NSInteger indexSearchPicture = [self.numberGenerator getRandomNumber0to3FromDate:[NSDate date]];
	self.rootView.questionLabel.text = charactersInfo[indexSearchPicture].name;
	[UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.rootView installFinishFrame];
	} completion: nil];
}

@end
