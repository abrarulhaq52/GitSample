//
//  NavigationController.m
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

// Shared Instance
+ (NavigationController *)defaultController
{
    static NavigationController *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[NavigationController alloc] init];
        
    });
    
    return sharedInstance;
}


-(UIViewController *) GetViewFromStoryboardWithID : (NSString *)ID
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:ID];
}


-(ICGNavigationController *)GetNavigationControllerWithRootViewControllerUsingID : (NSString *)ID
{
    ICGNavigationController *navigationController = [[ICGNavigationController alloc] initWithRootViewController:[self GetViewFromStoryboardWithID:ID]];
    navigationController.interactionEnabled = YES;
    navigationController.interactivePopGestureRecognizer.enabled = YES;
    ICGSlideAnimation *layerAnimation = [[ICGSlideAnimation alloc] initWithType:ICGSlideAnimationFromRight];
    navigationController.animationController = layerAnimation;
    navigationController.navigationBar.translucent = YES;

    return navigationController;
}





@end
