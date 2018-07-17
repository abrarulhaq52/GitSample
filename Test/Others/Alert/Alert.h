//
//  Alert.h
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIAlertController.h>
#import <CRToast/CRToast.h>
#import <MMPopLabel/MMPopLabel.h>
#import "SCLAlertView.h"

@interface Alert : NSObject <MMPopLabelDelegate>

+ (Alert *)allAlerts;

-(void)ShowAlertWithMessage : (NSString *) Message onViewController : (UIViewController *)vc;
-(void)ShowAlertWithMessage : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc;

-(void)ShowAlertWithMessageWithHandler : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc andCompletionHandler :(void (^) (UIAlertAction *))action;
-(void)ShowAlertWithMessagess : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc andHandler :(void (^) (UITextField *))text andCompletionHandler :(void (^) (UIAlertAction *))action;

-(void)ShowToastWithMessage : (NSString *) Message andTitle : (NSString *)title andTextAlignment : (NSTextAlignment)alignment andBackgroundColor : (UIColor *) bgColor  withIcon : (NSString *)image;
-(void)ShowPopUpWithMessage : (NSString *) Message onViewController: (UIViewController *) vc onView : (UIView *) view;
-(void)ShowErrorAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view;
-(void)ShowSuccessAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view;
-(void)ShowWarningAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view;
-(void)ShowInfoAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view;


@end
