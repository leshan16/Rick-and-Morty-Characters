//
//  AANetworkService.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AANetworkService.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/types.h>
#import <netinet/in.h>



@interface AANetworkService ()

@property (nonatomic, nonnull, strong) NSURLSession *urlSession;

@end


@implementation AANetworkService

- (void)makeNewRequest:(NSString *)urlString
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString: urlString];
    request.timeoutInterval = 10;
    
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
    if (arraySearchID.count < 4)
    {
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"https://rickandmortyapi.com/api/character/%@,%@,%@,%@",
                           arraySearchID[0], arraySearchID[1], arraySearchID[2], arraySearchID[3]];
    [self makeNewRequest:urlString];
}


- (NSData *)downloadCharacterImage:(NSString *)urlStringImage
{
    return [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlStringImage]];
}


- (BOOL)checkInternetConnection
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

@end
