//
//  NavigationController.h
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ICGNavigationController.h"
#import "ICGSlideAnimation.h"
@interface NavigationController : NSObject

+ (NavigationController *)defaultController;

-(UIViewController *) GetViewFromStoryboardWithID : (NSString *)ID;
-(ICGNavigationController *)GetNavigationControllerWithRootViewControllerUsingID : (NSString *)ID;

@end
