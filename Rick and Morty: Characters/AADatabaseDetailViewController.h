//
//  AADatabaseDetailViewController.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AACharacterModel;


/**
 ViewController, содержащий картинку и характеристики персонажа
 */
@interface AADatabaseDetailViewController : UIViewController

@property(nonatomic, nullable, strong) AACharacterModel *characterInfo; /**< Характеристики и картинка персонажа, 
                                                                         передаваемые из AADatabaseViewController*/

@end
