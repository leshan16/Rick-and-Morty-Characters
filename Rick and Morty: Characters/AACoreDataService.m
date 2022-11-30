//
//  AACoreDataService.m
//  Rick and Morty: Characters
//
//  Created by Апестин Алексей Дмитриевич on 29.11.2022.
//  Copyright © 2022 Алексей Апестин. All rights reserved.
//

#import "AACoreDataService.h"
#import "AACharacterModel.h"
#import "AACharacter+CoreDataProperties.h"
@import CoreData;


@interface AACoreDataService()

@property (nonatomic, nullable, strong) NSPersistentContainer *persistentContainer;

@end


@implementation AACoreDataService


static const NSInteger AANumberOfCharactersInsidePage = 20;


#pragma mark - AACoreDataServiceProtocol

- (NSArray<AACharacterModel *> *)getCharactersInfoForPage:(NSInteger)page {
	NSMutableArray<AACharacterModel *> *charactersInfo = [NSMutableArray new];
	NSFetchRequest *request = [self fetchRequestForPage:page];

	[self.persistentContainer.viewContext performBlockAndWait:^{
		NSArray<AACharacter *> *characters = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
		for (AACharacter *character in characters)
		{
			AACharacterModel *newCharacter = [AACharacterModel new];
			newCharacter.name = character.name;
			newCharacter.status = character.status;
			newCharacter.species = character.species;
			newCharacter.type = character.type;
			newCharacter.gender = character.gender;
			newCharacter.origin = character.origin;
			newCharacter.location = character.location;
			newCharacter.imageUrlString = character.imageUrlString;
			newCharacter.identifier = character.identifier;

			[charactersInfo addObject:newCharacter];
		}
	}];

	return [charactersInfo copy];
}

- (void)saveCharactersInfo:(NSArray<AACharacterModel *> *)charactersInfo {
	[self.persistentContainer.viewContext performBlock:^{
		for (AACharacterModel *character in charactersInfo)
		{
			AACharacter *newCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"AACharacter"
																	  inManagedObjectContext:self.persistentContainer.viewContext];
			newCharacter.name = character.name;
			newCharacter.status = character.status;
			newCharacter.species = character.species;
			newCharacter.type = character.type;
			newCharacter.gender = character.gender;
			newCharacter.origin = character.origin;
			newCharacter.location = character.location;
			newCharacter.imageUrlString = character.imageUrlString;
			newCharacter.identifier = character.identifier;
		}
		[self.persistentContainer.viewContext save:nil];
	}];
}


#pragma mark - Private

- (NSPersistentContainer *)persistentContainer
{
	@synchronized (self)
	{
		if (_persistentContainer == nil)
		{
			_persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Rick_and_Morty__Characters"];
			NSURL *url = [[NSURL alloc] initFileURLWithPath:@"/dev/null"];
			NSPersistentStoreDescription *description = [[NSPersistentStoreDescription alloc] initWithURL:url];
			_persistentContainer.persistentStoreDescriptions = @[description];
			[_persistentContainer loadPersistentStoresWithCompletionHandler:
			 ^(NSPersistentStoreDescription *storeDescription, NSError *error){
				 if (error != nil)
				 {
					 NSLog(@"Unresolved error %@, %@", error, error.userInfo);
					 abort();
				 }
			 }];
		}
	}
	return _persistentContainer;
}

- (NSFetchRequest *)fetchRequestForPage:(NSInteger)pageNumber
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AACharacter"];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"identifier > %ld AND identifier <= %ld",
							  (pageNumber - 1) * AANumberOfCharactersInsidePage,
							  pageNumber * AANumberOfCharactersInsidePage];
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];
	fetchRequest.sortDescriptors = @[sortDescriptor];

	return fetchRequest;
}


@end
