//
//  AppDelegate.m
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import "AppDelegate.h"
#import "ConjugateViewController.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize conjugateViewController;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *term = [[url absoluteString] substringFromIndex:10];
    if (self.conjugateViewController == nil)
    {
        ConjugateViewController *theConjugateViewController = [[[[self window] rootViewController] storyboard] instantiateViewControllerWithIdentifier:@"ConjugateViewController"];
        
        self.conjugateViewController = theConjugateViewController;
        self.conjugateViewController.verbToConjugate = term;
    }
    else
    {
        self.conjugateViewController.verbToConjugate = term;
        [self.conjugateViewController grabURLInBackground:self];
    }
    if (self.viewController == nil)
    {
        ViewController *theViewController = [[[[self window] rootViewController] storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
        
        self.viewController = theViewController;
    } 
    
    UINavigationController *mainViewNavController = [[UINavigationController alloc] init];
    
    if (viewController != nil)
    {
        [mainViewNavController pushViewController:viewController animated:FALSE];
    }
    
    if (self.conjugateViewController != nil)
    {
        [mainViewNavController pushViewController:self.conjugateViewController animated:FALSE];
    }
    
    [self.window setRootViewController:mainViewNavController];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
