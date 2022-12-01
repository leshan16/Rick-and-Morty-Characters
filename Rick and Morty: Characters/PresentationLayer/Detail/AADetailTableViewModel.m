//
//  AADetailTableViewModel.m
//  Rick and Morty: Characters
//
//  Created by Апестин Алексей Дмитриевич on 30.11.2022.
//  Copyright © 2022 Алексей Апестин. All rights reserved.
//

#import "AADetailTableViewModel.h"

@implementation AADetailTableViewModel

- (instancetype)initWithName:(NSString *)name value:(NSString *)value
{
	self = [super init];
	if (self)
	{
		_name = name;
		_value = value;
	}
	return self;
}

@end
