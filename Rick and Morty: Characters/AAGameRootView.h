//
//  AAGameRootView.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAGameRootViewProtocol.h"
#import "AAGameScoreLabel.h"
#import "AAGamePicture.h"
#import "AAGameQuestionLabel.h"
#import "AAActivityIndicatorView.h"


/**
 Контейнер для UI элементов, управляемых AAGameViewController
 */
@interface AAGameRootView : UIView <AAGameRootViewProtocol>

@property (nonatomic, weak) id<AAGamePictureProtocol> output; /**< Делегат внешних событий */
@property (nonatomic, strong) AAGameScoreLabel *scoreLabel; /**< Поле счета игрока */
@property (nonatomic, strong) AAGameScoreLabel *bestScoreLabel; /**< Поле лучшего счета игрока за все время */
@property (nonatomic, copy) NSArray<AAGamePicture *> *arrayPictures; /**< Массив четырех картинок персонажей */
@property (nonatomic, strong) AAGameQuestionLabel *questionLabel; /**< Поле с именем угадываемого персонажа */
@property (nonatomic, strong) AAActivityIndicatorView *activityIndicator; /**< Индикатор активности для отображения
                                                                           статуса получения данных из сети */

@end
