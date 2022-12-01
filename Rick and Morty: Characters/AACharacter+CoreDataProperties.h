//
//  AACharacter+CoreDataProperties.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AACharacter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN


@interface AACharacter (CoreDataProperties)

+ (NSFetchRequest<AACharacter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *species;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *origin;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *imageUrlString;
@property (nonatomic) int16_t identifier;

@end


NS_ASSUME_NONNULL_END
