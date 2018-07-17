//
//  Alert.m
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import "Alert.h"

@implementation Alert 

UIAlertController * AC;
MMPopLabel * poplabel;
SCLAlertView * SCLAV;
BOOL ToastStatus;

+ (Alert *)allAlerts
{
    static Alert *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[Alert alloc] init];
        ToastStatus = NO;
        
    });
    return sharedInstance;
}

-(void)ShowAlertWithMessage : (NSString *) Message onViewController : (UIViewController *)vc
{
    AC = [UIAlertController alertControllerWithTitle:@""
                                             message:Message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [AC addAction:defaultAction];
    [vc presentViewController:AC animated:YES completion:nil];
    
}
    // Present the alert view controller
-(void)ShowAlertWithMessage : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc
{
    AC = [UIAlertController alertControllerWithTitle:Title
                                             message:Message
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [AC addAction:defaultAction];
    [vc presentViewController:AC animated:YES completion:nil];
}

// Logout Popup
-(void)ShowAlertWithMessageWithHandler : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc andCompletionHandler :(void (^) (UIAlertAction *))action
{
    AC = [UIAlertController alertControllerWithTitle:Title
                                             message:Message
                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes!" style:UIAlertActionStyleDefault
                                                          handler:action];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No!" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];

//    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        // A block for configuring the text field prior to displaying the alert
//        textField.keyboardType = UIKeyboardTypeDefault;
//        textField.placeholder = @"Old Password";
//        textField.clearButtonMode = UITextFieldViewModeAlways;
//    }];
//    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        // A block for configuring the text field prior to displaying the alert
//        textField.placeholder = @"New Password";
//        textField.clearButtonMode = UITextFieldViewModeAlways;
//    }];
//    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        // A block for configuring the text field prior to displaying the alert
//        textField.placeholder = @"Confirm Password";
//        textField.clearButtonMode = UITextFieldViewModeAlways;
//    }];

    [AC addAction:defaultAction];
    [AC addAction:cancelAction];
    [vc presentViewController:AC animated:YES completion:nil];
}

-(void)ShowAlertWithMessagess : (NSString *) Message andTitle : (NSString *) Title onViewController : (UIViewController *)vc andHandler :(void (^) (UITextField *))text andCompletionHandler :(void (^) (UIAlertAction *))action
{
    AC = [UIAlertController alertControllerWithTitle:Title
                                             message:Message
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:action];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
    [AC addTextFieldWithConfigurationHandler:text];
    
    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        // A block for configuring the text field prior to displaying the alert
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"Old Password";
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        // A block for configuring the text field prior to displaying the alert
        textField.placeholder = @"New Password";
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [AC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        // A block for configuring the text field prior to displaying the alert
        textField.placeholder = @"Confirm Password";
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    
    [AC addAction:defaultAction];
    [AC addAction:cancelAction];
    [vc presentViewController:AC animated:YES completion:nil];
}

-(void)ShowToastWithMessage : (NSString *) Message andTitle : (NSString *)title andTextAlignment : (NSTextAlignment)alignment andBackgroundColor : (UIColor *) bgColor  withIcon : (NSString *)image
{
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(CRToastTypeNavigationBar),
                                      kCRToastNotificationPresentationTypeKey   : @(CRToastPresentationTypePush),
                                      kCRToastUnderStatusBarKey                 : @(NO),
                                      kCRToastTextKey                           : title,
                                      kCRToastTextAlignmentKey                  : @(alignment),
                                      kCRToastTimeIntervalKey                   : @(3),
                                      kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationInDirectionKey           : @(CRToastAnimationDirectionTop),
                                      kCRToastAnimationOutDirectionKey          : @(CRToastAnimationDirectionTop),
                                      kCRToastBackgroundColorKey                : bgColor
                                      
                                      } mutableCopy];
    
    options[kCRToastImageKey] = [UIImage imageNamed:image];
    options[kCRToastImageAlignmentKey] = @(CRToastAccessoryViewAlignmentLeft);
    options[kCRToastSubtitleTextKey] = Message;
    options[kCRToastSubtitleTextAlignmentKey] = @(alignment);
    options[kCRToastSubtitleTextAlignmentKey] = @(alignment);
    options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                  automaticallyDismiss:YES
                                                                                                                 block:^(CRToastInteractionType interactionType)
    {
        
    }]];

    if(!ToastStatus)
    {
        [CRToastManager showNotificationWithOptions:[NSDictionary dictionaryWithDictionary:options]
                                 apperanceBlock:^(void)
         {
             ToastStatus = YES;
             NSLog(@"Appeared");
     
         }
                                    completionBlock:^(void)
         {
             ToastStatus = NO;
             NSLog(@"Completed");
        
         }];
    }
}

-(void)ShowPopUpWithMessage : (NSString *) Message onViewController: (UIViewController *) vc onView : (UIView *) view
{
    [[MMPopLabel appearance] setLabelColor:[UIColor redColor]];
    [[MMPopLabel appearance] setLabelTextColor:[UIColor whiteColor]];
    //[[MMPopLabel appearance] setLabelTextHighlightColor:[UIColor whiteColor]];
    [[MMPopLabel appearance] setLabelFont:[UIFont fontWithName:@"Calibri" size:15]];
    poplabel = [MMPopLabel popLabelWithText:Message];
    poplabel.delegate = self;

    // add it to your view
    UIView * v = (UIView *)view;
    [vc.view addSubview:poplabel];
    [poplabel popAtView:v];
}

-(void)ShowErrorAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view
{
    SCLAV = [[SCLAlertView alloc] init];
    [SCLAV showError:view title:Title subTitle:Message closeButtonTitle:@"Ok" duration:0.0];
}

-(void)ShowSuccessAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view
{
    SCLAV = [[SCLAlertView alloc] init];
    [SCLAV showSuccess:view title:Title subTitle:Message closeButtonTitle:@"Ok" duration:0.0];
}

-(void)ShowWarningAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view
{
    SCLAV = [[SCLAlertView alloc] init];
    [SCLAV showWarning:view title:Title subTitle:Message closeButtonTitle:@"Ok" duration:0.0];
}

-(void)ShowInfoAlertWithMessage : (NSString*) Message andTitle :(NSString *)Title onViewController : (UIViewController *)view
{
    SCLAV = [[SCLAlertView alloc] init];
    [SCLAV showInfo:view title:Title subTitle:Message closeButtonTitle:@"Ok" duration:0.0];
}
@end
