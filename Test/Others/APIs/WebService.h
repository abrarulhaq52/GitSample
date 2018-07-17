/*!
 @header WebService.h
 
 @brief This header contains methods to get different @b Web @b Services for client-server communication.
 
 @author Abrar
 @copyright Copyright © 2018 Ilmasoft. All rights reserved.
 @version   1.0
 */

#import <Foundation/Foundation.h>
/*!
 @class The @b WebService Class.
 @brief This @b WebService Class contains methods to get different @a Web @a Services for @a client-server @a communication.
 @interface Font
 @superclass The superclass of the current class is @a NSObject.
 @classdesign The @b WebService is a @a singleton class.
 */
@interface WebService : NSObject

// Shared Instance Initializer
+ (WebService *)sharedServices;

// GetNyTime Api
-(void) GetNYTimesApiKey: (NSString *)apiKey andCompletionHandler:(void (^)(NSDictionary *))dataReceived;


-(NSDictionary *)DictionaryFromData : (NSData *)data;

@end
