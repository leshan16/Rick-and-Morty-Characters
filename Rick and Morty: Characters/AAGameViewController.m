//
//  AAGameViewController.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameViewController.h"
#import "AAGameScoreLabel.h"
#import "AAGamePicture.h"
#import "AAGameQuestionLabel.h"
#import "AANetworkService.h"
#import "AAActivityIndicatorView.h"

static const NSInteger AANumberOfCharactersInTotal = 493;


@interface AAGameViewController () <AANetworkServiceOutputProtocol, AAGamePictureProtocol>

@property (nonatomic, strong) AAGameScoreLabel *scoreLabel;
@property (nonatomic, strong) AAGameScoreLabel *bestScoreLabel;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSArray<AAGamePicture *> *arrayPictures;
@property (nonatomic, strong) AAGameQuestionLabel *questionLabel;
@property (nonatomic, strong) AANetworkService *networkService;
@property (nonatomic, strong) AAActivityIndicatorView *activityIndicator;

@end


@implementation AAGameViewController

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
    self.view.layer.contents = (id)[UIImage imageNamed:@"GameLayer"].CGImage;
    
    self.score = 0;
    self.scoreLabel = [[AAGameScoreLabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame) / 3,
                                                                         CGRectGetWidth(self.view.frame) / 12)];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    [self.view addSubview:self.scoreLabel];
    
    self.bestScoreLabel = [[AAGameScoreLabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) -
                                                                             CGRectGetWidth(self.view.frame) / 3, 30,
                                                                             CGRectGetWidth(self.view.frame) / 3,
                                                                             CGRectGetWidth(self.view.frame) / 12)];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"Best: %ld", (long)[[NSUserDefaults standardUserDefaults]
                                                                               integerForKey:@"BestScore"]];
    [self.view addSubview:self.bestScoreLabel];
    
    self.questionLabel = [[AAGameQuestionLabel alloc] initWithFrame:[self resultFrameQuestionLabel]];
    self.questionLabel.text = @"Question string";
    [self.view addSubview:self.questionLabel];
    
    AAGamePicture *leftUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftUpPicture]];
    leftUpPicture.output = self;
    [self.view addSubview:leftUpPicture];
    
    AAGamePicture *rightUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightUpPicture]];
    rightUpPicture.output = self;
    [self.view addSubview:rightUpPicture];
    
    AAGamePicture *leftDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftDownPicture]];
    leftDownPicture.output = self;
    [self.view addSubview:leftDownPicture];
    
    AAGamePicture *rightDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightDownPicture]];
    rightDownPicture.output = self;
    [self.view addSubview:rightDownPicture];
    
    self.arrayPictures = @[leftUpPicture, rightUpPicture, leftDownPicture, rightDownPicture];
    
    self.activityIndicator = [[AAActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
                                                       CGRectGetHeight(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) / 8,
                                                       CGRectGetWidth(self.view.frame) / 4, CGRectGetWidth(self.view.frame) / 4)];
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    self.networkService = [AANetworkService new];
    self.networkService.output = self;
    
    [self installStartFrame];
    [self getNewQuestion];
}


- (void)installStartFrame
{
    CGRect startFrame = CGRectMake(CGRectGetWidth(self.view.frame) / 2,
                                   (CGRectGetMinY(self.questionLabel.frame) - CGRectGetMaxY(self.scoreLabel.frame)) / 2 +
                                   CGRectGetMaxY(self.scoreLabel.frame), 0, 0);
    for (AAGamePicture *gamePicture in self.arrayPictures)
    {
        gamePicture.frame = startFrame;
    }
    self.questionLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetMinY(self.questionLabel.frame),
                                          0, CGRectGetHeight(self.questionLabel.frame));
}


- (CGRect)resultFrameLeftUpPicture
{
    return CGRectMake(0, (CGRectGetMinY(self.questionLabel.frame) - CGRectGetMaxY(self.scoreLabel.frame)) / 2 +
                      CGRectGetMaxY(self.scoreLabel.frame) - CGRectGetWidth(self.view.frame) / 2 - 1,
                      CGRectGetWidth(self.view.frame) / 2 - 1, CGRectGetWidth(self.view.frame) / 2);
}


- (CGRect)resultFrameRightUpPicture
{
    return CGRectMake(CGRectGetWidth(self.arrayPictures[0].frame) + 2, CGRectGetMinY(self.arrayPictures[0].frame),
                      CGRectGetWidth(self.view.frame) / 2 - 1, CGRectGetWidth(self.view.frame) / 2);
}


- (CGRect)resultFrameLeftDownPicture
{
    return CGRectMake(0, CGRectGetMaxY(self.arrayPictures[0].frame) + 2, CGRectGetWidth(self.view.frame) / 2 - 2,
                      CGRectGetWidth(self.view.frame) / 2);
}


- (CGRect)resultFrameRightDownPicture
{
    return CGRectMake(CGRectGetWidth(self.arrayPictures[0].frame) + 2, CGRectGetMaxY(self.arrayPictures[0].frame) + 2,
               CGRectGetWidth(self.view.frame) / 2 - 1, CGRectGetWidth(self.view.frame) / 2);
}


- (CGRect)resultFrameQuestionLabel
{
    return CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetWidth(self.view.frame) / 8 - 80,
                      CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 8);
}


#pragma mark - Create new question

- (void)getNewQuestion
{
    NSDateComponents *dateComponents = [self getDateComponents];
    
    NSInteger hour = [dateComponents hour] + 1;
    NSInteger minute = [dateComponents minute] + 1;
    NSInteger second = [dateComponents second] + 1;
    NSInteger searchID = (second * minute * hour) % AANumberOfCharactersInTotal + 1;
    
    NSMutableArray *arraySearchIDCharacters = [NSMutableArray new];
    [arraySearchIDCharacters addObject:@(searchID)];
    
    for (int i = 1; i < 4; i++)
    {
        NSInteger nextID = searchID + second * i;
        if (nextID > AANumberOfCharactersInTotal)
        {
            nextID = searchID - second * i;
        }
        [arraySearchIDCharacters addObject:@(nextID)];
    }
    [self.activityIndicator startAnimating];
    [self.networkService downloadCharactersInfoForGame:arraySearchIDCharacters];
}


- (NSDateComponents *)getDateComponents
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
}


#pragma mark - AANetworkServiceOutputProtocol

- (void)downloadNewPage:(NSData *)charactersInfo
{
    [self.activityIndicator stopAnimating];
    if (!charactersInfo)
    {
        [self showAlert:@"No internet connection"];
        return;
    }
    NSArray *arrayCharacterInfo = [NSJSONSerialization JSONObjectWithData:charactersInfo options:kNilOptions error:nil];
    NSInteger indexItem = 0;
    for (NSDictionary *item in arrayCharacterInfo)
    {
        self.arrayPictures[indexItem].characterName = item[@"name"];
        self.arrayPictures[indexItem].image = [UIImage imageWithData:[self.networkService downloadCharacterImage:item[@"image"]]];
        indexItem++;
    }
    NSDateComponents *dateComponents = [self getDateComponents];
    NSInteger indexSearchPicture = [dateComponents second] % 3;
    self.questionLabel.text = self.arrayPictures[indexSearchPicture].characterName;
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.questionLabel.frame = [self resultFrameQuestionLabel];
        self.arrayPictures[0].frame = [self resultFrameLeftUpPicture];
        self.arrayPictures[1].frame = [self resultFrameRightUpPicture];
        self.arrayPictures[2].frame = [self resultFrameLeftDownPicture];
        self.arrayPictures[3].frame = [self resultFrameRightDownPicture];
        for (AAGamePicture *gamePicture in self.arrayPictures)
        {
            gamePicture.layer.borderColor = UIColor.blackColor.CGColor;
        }
    } completion: nil];
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
    for (AAGamePicture *gamePicture in self.arrayPictures)
    {
        if ([gamePicture.characterName isEqualToString:self.questionLabel.text])
        {
            gamePicture.layer.borderColor = UIColor.greenColor.CGColor;
        }
        else
        {
            gamePicture.layer.borderColor = UIColor.redColor.CGColor;
        }
    }
    if ([picture.characterName isEqualToString:self.questionLabel.text])
    {
        self.score++;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (self.score > [defaults integerForKey:@"BestScore"])
        {
            [defaults setInteger:self.score forKey:@"BestScore"];
            self.bestScoreLabel.text = [NSString stringWithFormat:@"Best: %ld", (long)self.score];
        }
    }
    else
    {
        self.score = 0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self installStartFrame];
    } completion:nil];
    [self getNewQuestion];
}

@end
