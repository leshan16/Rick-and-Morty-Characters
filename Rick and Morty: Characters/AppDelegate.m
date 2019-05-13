//
//  AppDelegate.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AppDelegate.h"
#import "AAGameViewController.h"
#import "AADatabaseViewController.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    AADatabaseViewController *databaseViewController = [AADatabaseViewController new];
    databaseViewController.tabBarItem.title = @"Database";
    databaseViewController.tabBarItem.image = [UIImage imageNamed:@"Database"];
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:databaseViewController];
    
    AAGameViewController *gameViewController = [AAGameViewController new];
    gameViewController.tabBarItem.title = @"Game";
    gameViewController.tabBarItem.image = [UIImage imageNamed:@"Search"];
    
    NSArray *viewControllerArray = @[navigationController, gameViewController];
    UITabBarController *tabBarViewController = [UITabBarController new];
    tabBarViewController.tabBar.translucent = YES;
    tabBarViewController.tabBar.itemPositioning = UITabBarItemPositioningFill;
    tabBarViewController.tabBar.tintColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1];
    tabBarViewController.tabBar.barTintColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    tabBarViewController.tabBar.unselectedItemTintColor = UIColor.blackColor;
    tabBarViewController.viewControllers = viewControllerArray;
    
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
