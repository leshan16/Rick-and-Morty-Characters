//
//  AADataService.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADataRepository.h"
#import "AANetworkService.h"
#import "AACoreDataService.h"
#import "AACharacterModel.h"
#import "AACharacter+CoreDataClass.h"


@interface AADataRepository()

@property (nonatomic, nonnull, strong) id<AANetworkServiceProtocol> networkService;
@property (nonatomic, nonnull, strong) id<AACoreDataServiceProtocol> coreDataService;

@end


@implementation AADataRepository

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _networkService = [AANetworkService new];
		_coreDataService = [AACoreDataService new];
    }
    return self;
}


#pragma mark - AADataServiceInputProtocol

- (void)getCharactersInfoForPage:(NSInteger)page
{
	NSArray<AACharacterModel *> *charactersFromCoreData = [self.coreDataService getCharactersInfoForPage:page];
    if (charactersFromCoreData.count > 0)
    {
		[self presentCharactersInfo:charactersFromCoreData];
		return;
	}

	[self.networkService downloadCharactersInfoForPage:page completionHandler:^(NSData * _Nullable pageData) {
		if (!pageData)
		{
			[self.output didRecieveErrorWithDescription:@"No internet connection"];
			return;
		}
		NSDictionary *result = [NSJSONSerialization JSONObjectWithData:pageData options:kNilOptions error:nil];
		NSArray<AACharacterModel *> *characterModels = [self makeCharacterModelsFromJSON:result[@"results"]];
		[self.coreDataService saveCharactersInfo:characterModels];
		[self presentCharactersInfo:characterModels];
	}];
}

- (void)getCharactersInfoForIds:(NSArray<NSNumber *> *)arraySearchID
{
	[self.networkService downloadCharactersInfoForIds:arraySearchID completionHandler:^(NSData * _Nullable data) {
		if (!data)
		{
			[self.output didRecieveErrorWithDescription:@"No internet connection"];
			return;
		}
		NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
		NSArray<AACharacterModel *> *characterModels = [self makeCharacterModelsFromJSON:result];
		[self presentCharactersInfo:characterModels];
	}];
}


#pragma mark - Private

- (void)presentCharactersInfo:(NSArray<AACharacterModel *> *)characters
{
    dispatch_group_t group = dispatch_group_create();

    for (AACharacterModel *character in characters)
    {
		dispatch_group_enter(group);
		[self.networkService downloadCharacterImage:character.imageUrlString completionHandler:^(NSData * _Nullable imageData) {
			character.image = [UIImage imageWithData:imageData];
			dispatch_group_leave(group);
		}];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.output didLoadCharactersInfo:characters];
    });
}

- (NSArray<AACharacterModel *> *)makeCharacterModelsFromJSON:(NSArray *)arrayCharacterInfo
{
	NSMutableArray<AACharacterModel *> *characterModels = [NSMutableArray new];

	for (NSDictionary *item in arrayCharacterInfo)
	{
		AACharacterModel *newCharacter = [AACharacterModel new];
		newCharacter.name = item[@"name"];
		newCharacter.status = item[@"status"];
		newCharacter.species = item[@"species"];
		newCharacter.type = item[@"type"];
		newCharacter.gender = item[@"gender"];
		newCharacter.origin = item[@"origin"][@"name"];
		newCharacter.location = item[@"location"][@"name"];
		newCharacter.imageUrlString = item[@"image"];
		NSNumber *identifier = item[@"id"];
		newCharacter.identifier = [identifier integerValue];
		[characterModels addObject:newCharacter];
	}

	return [characterModels copy];
}


@end
