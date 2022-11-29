//
//  AAGameViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameViewController.h"
#import "AANetworkService.h"
#import "AAGameRandomNumbers.h"
#import "AAGameRootView.h"


@interface AAGameViewController () <AAGamePictureProtocol>

@property (nonatomic, nullable, strong) AAGameRootView *rootView;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, nullable, strong) AANetworkService *networkService;

@end


@implementation AAGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}


#pragma mark - Prepare UI

- (void)prepareUI
{
    self.rootView = [[AAGameRootView alloc] initWithFrame:self.view.frame];
    self.rootView.output = self;
    NSString *textScore = [NSString stringWithFormat:@"Best: %ld", (long)[[NSUserDefaults standardUserDefaults]
                                                                          integerForKey:@"BestScore"]];
    self.rootView.bestScoreLabel.text = textScore;
    [self.rootView installStartFrame];
    [self.view addSubview:self.rootView];
    self.score = 0;
    self.networkService = [AANetworkService new];
    [self getNewQuestion];
}


#pragma mark - Create new question

- (void)getNewQuestion
{
    NSArray<NSNumber *> *arraySearchID = [AAGameRandomNumbers getRandomFourNumbersFrom1to493:[NSDate date]];
    [self.rootView.activityIndicator startAnimating];
	[self.networkService downloadCharactersInfoForIds:arraySearchID completionHandler:^(NSData * _Nullable charactersData) {
		[self.rootView.activityIndicator stopAnimating];
		if (!charactersData)
		{
			[self showAlert:@"No internet connection"];
			return;
		}
		NSArray *arrayCharacterInfo = [NSJSONSerialization JSONObjectWithData:charactersData options:kNilOptions error:nil];
		NSInteger indexItem = 0;
		dispatch_group_t group = dispatch_group_create();
		for (NSDictionary *item in arrayCharacterInfo)
		{
			self.rootView.arrayPictures[indexItem].characterName = item[@"name"];
			dispatch_group_enter(group);
			[self.networkService downloadCharacterImage:item[@"image"] completionHandler:^(NSData * _Nullable imageData) {
				if (imageData)
				{
					self.rootView.arrayPictures[indexItem].image = [UIImage imageWithData:imageData];
				}
				dispatch_group_leave(group);
			}];
			indexItem++;
		}
		dispatch_group_notify(group, dispatch_get_main_queue(), ^{
			NSInteger indexSearchPicture = [AAGameRandomNumbers getRandomNumberFrom0to3:[NSDate date]];
			self.rootView.questionLabel.text = self.rootView.arrayPictures[indexSearchPicture].characterName;
			[UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				[self.rootView installFinishFrame];
			} completion: nil];
		});
	}];
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

- (void)pictureSelected:(AAGamePicture *)picture
{
    for (AAGamePicture *gamePicture in self.rootView.arrayPictures)
    {
        if ([gamePicture.characterName isEqualToString:self.rootView.questionLabel.text])
        {
            gamePicture.layer.borderColor = UIColor.greenColor.CGColor;
        }
        else
        {
            gamePicture.layer.borderColor = UIColor.redColor.CGColor;
        }
    }
    if ([picture.characterName isEqualToString:self.rootView.questionLabel.text])
    {
        self.score++;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (self.score > [defaults integerForKey:@"BestScore"])
        {
            [defaults setInteger:self.score forKey:@"BestScore"];
            self.rootView.bestScoreLabel.text = [NSString stringWithFormat:@"Best: %ld", (long)self.score];
        }
    }
    else
    {
        self.score = 0;
    }
    self.rootView.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.rootView installStartFrame];
    } completion:nil];
    [self getNewQuestion];
}

@end
