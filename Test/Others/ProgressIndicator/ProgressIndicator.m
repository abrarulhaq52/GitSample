//
//  ProgressIndicator.m
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import "ProgressIndicator.h"
#import "AppDelegate.h"

@implementation ProgressIndicator

+ (ProgressIndicator *)sharedInstance{
    static ProgressIndicator *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[ProgressIndicator alloc] init];
    });
    return sharedInstance;
}

-(void) ShowAngularWithText : (NSString *) text OnView : (UIViewController *)vc
{
    hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = text;
}

-(void) ShowDeterminateWithText : (NSString *) text OnView : (UIViewController *)vc
{
    hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = text;
}
-(void) ShowDimBackground : (NSString *) text OnView : (UIViewController *)vc
{
    hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.dimBackground  = YES;
    hud.labelText = text;
}
-(void) ShowDimBackground : (NSString *) text
{
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.dimBackground  = YES;
    hud.labelText = text;
}
-(void) HideOnView : (UIViewController *)vc
{
    [MBProgressHUD hideHUDForView:vc.view animated:YES];
}
-(void) HideAfterSeconds : (float)seconds
{
    [hud hide:YES afterDelay:seconds];
}
-(void) Hide
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [MBProgressHUD hideHUDForView:app.window animated:YES];
    });
    
}

@end
