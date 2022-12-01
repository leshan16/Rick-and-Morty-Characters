//
//  AACharacter+CoreDataProperties.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AACharacter+CoreDataProperties.h"


@implementation AACharacter (CoreDataProperties)

+ (NSFetchRequest<AACharacter *> *)fetchRequest
{
	return [[NSFetchRequest alloc] initWithEntityName:@"AACharacter"];
}

@dynamic name;
@dynamic status;
@dynamic species;
@dynamic type;
@dynamic gender;
@dynamic origin;
@dynamic location;
@dynamic imageUrlString;
@dynamic identifier;

@end
