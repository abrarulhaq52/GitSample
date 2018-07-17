//
//  ProgressIndicator.h
//  SSD
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface ProgressIndicator : NSObject
{
    MBProgressHUD *hud;
}
+ (ProgressIndicator *)sharedInstance;

-(void) ShowAngularWithText : (NSString *) text OnView : (UIViewController *)vc;
-(void) ShowDimBackground : (NSString *) text OnView : (UIViewController *)vc;
-(void) ShowDimBackground : (NSString *) text;

-(void) ShowDeterminateWithText : (NSString *) text OnView : (UIViewController *)vc;
-(void) HideOnView : (UIViewController *)vc;
-(void) HideAfterSeconds : (float)seconds;
-(void) Hide;

@end
