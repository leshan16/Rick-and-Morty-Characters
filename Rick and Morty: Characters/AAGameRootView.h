//
//  AAGameRootView.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameRootViewInputProtocol.h"
#import "AAGamePicture.h"
@import UIKit;
@protocol AAGameRootViewOutputProtocol;


/**
 Контейнер для UI элементов, управляемых AAGameViewController
 */
@interface AAGameRootView : UIView <AAGameRootViewInputProtocol>

@property (nonatomic, nullable, weak) id<AAGameRootViewOutputProtocol> output; /**< Делегат внешних событий */
@property (nonatomic, nullable, strong) UILabel *scoreLabel; /**< Поле счета игрока */
@property (nonatomic, nullable, strong) UILabel *bestScoreLabel; /**< Поле лучшего счета игрока за все время */
@property (nonatomic, nullable, copy) NSArray<AAGamePicture *> *arrayPictures; /**< Массив четырех картинок персонажей */
@property (nonatomic, nullable, strong) UILabel *questionLabel; /**< Поле с именем угадываемого персонажа */
@property (nonatomic, nullable, strong) UIActivityIndicatorView *activityIndicator; /**< Индикатор активности для отображения статуса получения данных из сети */

@end
