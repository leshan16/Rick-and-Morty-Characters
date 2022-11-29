//
//  AANetworkService.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AANetworkService.h"
@import SystemConfiguration;
@import Darwin;


@interface AANetworkService ()

@property (nonatomic, nullable, strong) NSURLSession *urlSession;

@end


@implementation AANetworkService


#pragma mark - AANetworkServiceProtocol

- (void)downloadCharactersInfoForPage:(NSInteger)page completionHandler:(void (^)(NSData * _Nullable))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"https://rickandmortyapi.com/api/character/?page=%ld", (long)page];
    [self performRequestForURL:urlString completion:completionHandler];
}

- (void)downloadCharactersInfoForIds:(NSArray<NSNumber *> *)arraySearchID completionHandler:(void (^)(NSData * _Nullable))completionHandler
{
	NSString *ids = [arraySearchID componentsJoinedByString:@","];
    NSString *urlString = [NSString stringWithFormat:@"https://rickandmortyapi.com/api/character/%@", ids];
    [self performRequestForURL:urlString completion:completionHandler];
}

- (void)downloadCharacterImage:(nullable NSString *)urlStringImage completionHandler:(void (^)(NSData * _Nullable))completionHandler;
{
	return [self performRequestForURL:urlStringImage completion:completionHandler];
}

- (BOOL)isInternetConnectionAvailable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)
                                                                                               &zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    
    return ((isReachable && !needsConnection) || nonWiFi);
}


#pragma mark - Private

- (NSURLSession *)urlSession
{
	if (!_urlSession)
	{
		_urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	}

	return _urlSession;
}

- (void)performRequestForURL:(NSString *)urlString completion:(void (^)(NSData * _Nullable))completion
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	request.URL = [NSURL URLWithString: urlString];
	request.timeoutInterval = 10;
	NSLog(@"Запрос был отправлен по URL: %@", urlString);

	NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request
															   completionHandler:^(NSData * _Nullable data,
																				   NSURLResponse * _Nullable response,
																				   NSError * _Nullable error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(data);
		});
		NSLog(@"Ответ был получен по URL: %@", urlString);
	}];
	[sessionDataTask resume];
}


@end
