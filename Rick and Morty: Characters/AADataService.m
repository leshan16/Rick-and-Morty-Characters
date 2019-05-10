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


@import CoreData;

static const NSInteger AANumberOfCharactersInsidePage = 20;


@interface AADataService() <AANetworkServiceOutputProtocol>

@property (nonatomic, strong) AANetworkService *networkService;
@property (nonatomic, strong) NSMutableArray<AACharacterModel *> *arrayCharacters;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, copy) NSArray<AACharacter *> *arrayCharactersFromCoreData;

@end


@implementation AADataService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _networkService = [AANetworkService new];
        _networkService.output = self;
        _pageNumber = 1;
    }
    return self;
}


- (void)getCharactersInfo
{
    NSError *error = nil;
    self.arrayCharactersFromCoreData = [self.coreDataContext executeFetchRequest:self.fetchRequest ? :
                                        [AACharacter fetchRequest] error:&error];
    if (self.arrayCharactersFromCoreData.count == 0)
    {
        [self.networkService downloadCharactersInfo:self.pageNumber];
    }
    else
    {
        [self.networkService checkInternetConnection];
    }
}


#pragma mark - AADataServiceInputProtocol

- (void)downloadNewPage:(NSData *)charactersInfo
{
    if (!charactersInfo)
    {
        [self.output showAlert:@"No internet connection"];
        return;
    }
    NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:charactersInfo options:kNilOptions error:nil];
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
}


- (void)getCharactersInfoFromCoreData:(BOOL)isInternetConnection
{
    if (!isInternetConnection)
    {
        [self.output showAlert:@"No internet connection"];
    }
    dispatch_queue_t concurrentQueueForDownloadImages = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t groupForDownloadImages = dispatch_group_create();
    NSMutableArray<AACharacterModel *> *resultArrayInfo = [NSMutableArray new];
    
    for (AACharacter *character in self.arrayCharactersFromCoreData)
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
        dispatch_group_async(groupForDownloadImages, concurrentQueueForDownloadImages, ^{
            if (isInternetConnection)
            {
                newCharacter.image = [UIImage imageWithData:[self.networkService
                                                             downloadCharacterImage:character.imageUrlString]];
            }
            else
            {
                newCharacter.image = nil;
            }
        });
        [resultArrayInfo addObject:newCharacter];
    }
    dispatch_group_notify(groupForDownloadImages, dispatch_get_main_queue(), ^{
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
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).
    persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

@end
