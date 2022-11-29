//
//  AADataService.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADataService.h"
#import "AANetworkService.h"
#import "AANetworkServiceProtocol.h"
#import "AACharacterModel.h"
#import "AppDelegate.h"
#import "AACharacter+CoreDataClass.h"
#import <CoreData/CoreData.h>


@import CoreData;

static const NSInteger AANumberOfCharactersInsidePage = 20;


@interface AADataService()

@property (nonatomic, nonnull, strong) AANetworkService *networkService;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, nullable, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, nullable, strong) NSFetchRequest *fetchRequest;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end


@implementation AADataService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _networkService = [AANetworkService new];
        _pageNumber = 1;
    }
    return self;
}


#pragma mark - AADataServiceInputProtocol

- (void)getCharactersInfo
{
    NSError *error = nil;
    NSArray<AACharacter *> *arrayCharactersFromCoreData = [self.coreDataContext executeFetchRequest:self.fetchRequest ? :
                                        [AACharacter fetchRequest] error:&error];
    if (arrayCharactersFromCoreData.count == 0)
    {
		[self.networkService downloadCharactersInfoForPage:self.pageNumber completionHandler:^(NSData * _Nullable pageData) {
			if (!pageData)
			{
				[self.output showAlert:@"No internet connection"];
				return;
			}
			NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:pageData options:kNilOptions error:nil];
			NSArray *arrayCharacterInfo = temp[@"results"];
			for (NSDictionary *item in arrayCharacterInfo)
			{
				AACharacter *newCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"AACharacter"
																		  inManagedObjectContext:self.coreDataContext];
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
				NSError *error = nil;
				[newCharacter.managedObjectContext save:&error];
			}
			[self getCharactersInfo];
		}];
    }
    else
    {
        [self getCharactersInfoFromCoreData:arrayCharactersFromCoreData];
    }
}


- (void)getCharactersInfoFromCoreData:(NSArray<AACharacter *> *)arrayCharactersFromCoreData
{
    BOOL isInternetConnection = [self.networkService isInternetConnectionAvailable];
    if (!isInternetConnection)
    {
        [self.output showAlert:@"No internet connection"];
    }
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray<AACharacterModel *> *resultArrayInfo = [NSMutableArray new];
    
    for (AACharacter *character in arrayCharactersFromCoreData)
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
		if (isInternetConnection)
		{
			dispatch_group_enter(group);
			[self.networkService downloadCharacterImage:character.imageUrlString completionHandler:^(NSData * _Nullable imageData) {
				newCharacter.image = [UIImage imageWithData:imageData];
				dispatch_group_leave(group);
			}];

		}
		else
		{
			newCharacter.image = nil;
		}
		[resultArrayInfo addObject:newCharacter];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.pageNumber++;
        [self.output addNewPage:resultArrayInfo];
    });
}



#pragma mark - Property getters

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AACharacter"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"identifier > %ld AND identifier <= %ld",
                              (self.pageNumber - 1) * AANumberOfCharactersInsidePage,
                              self.pageNumber * AANumberOfCharactersInsidePage];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
        
    return fetchRequest;
}


- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    return context;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self)
    {
        if (_persistentContainer == nil)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Rick_and_Morty__Characters"];
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


@end
