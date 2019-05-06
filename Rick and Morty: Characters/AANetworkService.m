//
//  AANetworkService.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AANetworkService.h"


@interface AANetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;

@end


@implementation AANetworkService

- (void)makeNewRequest:(NSString *)urlString
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setTimeoutInterval:10];
    
    if (!self.urlSession)
    {
        self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request
                                                               completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
                                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                                       [self.output downloadNewPage:data];
                                                                   });
                                                               }];
    [sessionDataTask resume];
}


#pragma mark - AANetworkServiceIntputProtocol

- (void)downloadCharactersInfo:(NSInteger)page
{
    NSString *urlString = [NSString stringWithFormat:@"https://rickandmortyapi.com/api/character/?page=%ld", (long)page];
    [self makeNewRequest:urlString];
}


- (void)downloadCharactersInfoForGame:(NSArray<NSNumber *> *)arraySearchID
{
    NSString *urlString = [NSString stringWithFormat:@"https://rickandmortyapi.com/api/character/%@,%@,%@,%@",
                           arraySearchID[0], arraySearchID[1], arraySearchID[2], arraySearchID[3]];
    [self makeNewRequest:urlString];
}


- (NSData *)downloadCharacterImage:(NSString *)urlStringImage
{
    return [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlStringImage]];
}


- (void)checkInternetConnection
{
    NSString *urlString = @"https://www.google.com/";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"HEAD"];
    
    if (!self.urlSession)
    {
        self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request
                                                               completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
        if ([self.output respondsToSelector:@selector(getCharactersInfoFromCoreData:)])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.output getCharactersInfoFromCoreData:(data == nil) ? NO : YES];
            });
        }
    }];
    [sessionDataTask resume];
}

@end
