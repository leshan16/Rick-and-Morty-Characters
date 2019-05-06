//
//  AADatabaseCharacterModel.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Модель персонажа аналогичная модели из кор даты, дополненная картинкой
 */
@interface AACharacterModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *species;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *imageUrlString;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) UIImage *image;

@end
