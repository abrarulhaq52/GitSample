//
//  Configuration.h
//  Test
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h

// <================ Macros: ================>

// Choose Device
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1024)
#define iPadPro ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1112)
#define iPadPro12 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1366)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )

#define screen_width [ [ UIScreen mainScreen ] bounds ].size.width
#define screen_height [ [ UIScreen mainScreen ] bounds ].size.height

// Title Fonts Sizes:
#define iPadPro12TitleFont [UIFont systemFontOfSize:25]
#define iPadPro10TitleFont [UIFont systemFontOfSize:23]
#define iPadTitleFont [UIFont systemFontOfSize:21]
#define iPhoneTitleFont [UIFont systemFontOfSize:19]
#define iPhone6TitleFont [UIFont systemFontOfSize:17]
#define iPhone5TitleFont [UIFont systemFontOfSize:15]

// Detail Fonts Sizes:
#define iPadPro12DetailFont [UIFont systemFontOfSize:22]
#define iPadPro10DetailFont [UIFont systemFontOfSize:20]
#define iPadDetailFont [UIFont systemFontOfSize:18]
#define iPhoneDetailFont [UIFont systemFontOfSize:16]
#define iPhone6DetailFont [UIFont systemFontOfSize:14]
#define iPhone5DetailFont [UIFont systemFontOfSize:12]

// Sub Detail Fonts Sizes:
#define iPadPro12SubDetailFont [UIFont systemFontOfSize:19]
#define iPadPro10SubDetailFont [UIFont systemFontOfSize:17]
#define iPadSubDetailFont [UIFont systemFontOfSize:15]
#define iPhoneSubDetailFont [UIFont systemFontOfSize:13]
#define iPhone6SubDetailFont [UIFont systemFontOfSize:11]
#define iPhone5SubDetailFont [UIFont systemFontOfSize:9]

#endif /* Configuration_h */


