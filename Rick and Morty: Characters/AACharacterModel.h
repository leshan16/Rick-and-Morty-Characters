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

@property (nonatomic, nullable, copy) NSString *name;
@property (nonatomic, nullable, copy) NSString *status;
@property (nonatomic, nullable, copy) NSString *species;
@property (nonatomic, nullable, copy) NSString *type;
@property (nonatomic, nullable, copy) NSString *gender;
@property (nonatomic, nullable, copy) NSString *origin;
@property (nonatomic, nullable, copy) NSString *location;
@property (nonatomic, nullable, copy) NSString *imageUrlString;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, nullable, strong) UIImage *image;

@end
