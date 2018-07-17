//
//  WebService.m
//  Queens International School Dubai
//
//  Created by Abrar on 17/07/2018.
//  Copyright © 2018 Ilmasoft. All rights reserved.
//


#import "WebService.h"
#import "ProgressIndicator.h"
@implementation WebService

/// It contains sub url for mobile api
//static NSString * DataServices;

/*!
 @brief Initializes single and shared Instance of the @b WebService Class.
 To use it simply write code given below @code [WebService sharedInstance]; @endcode
 @return Shared instance of the @b WebService.
  */
+ (WebService *)sharedServices{
    static WebService *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[WebService alloc] init];
        
    });
    return sharedInstance;
}

-(void) GetNYTimesApiKey: (NSString *)apiKey andCompletionHandler:(void (^)(NSDictionary *))dataReceived{
    
    [[ProgressIndicator sharedInstance] ShowDimBackground:@"Getting Directions..."];
    [self getDictionaryFromURLRequest:[self GetRequestWithURL:[self GetEncodedURL:[NSString stringWithFormat:@"http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=d01029d28b2f49a1adaa58209ff5f426"]] andParameters:[NSString stringWithFormat:@""]] andCompletionHandler:^(NSDictionary * response){ dataReceived(response); }];
    
}

// Common Function for Encoding String URL

/*!
 @brief Return URL Request by combining URL and Parameters.
 @discussion It uses @GET method as default but can be changed to some other in configuration.h file
 @param url @b (NSURL @b*) @a Encoded @a URL of API or Web Service.
 @param parameters @b (NSString @b*) @a Parameters appended by & sign (i.e. param1=abc&param2=123)
 @return @b(NSURL @b*).
  */
-(NSMutableURLRequest *)GetRequestWithURL : (NSURL *)url andParameters : (NSString *)parameters{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    if(nil != parameters)
        [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}
/*!
 @brief Return Encoded @b URL from String with URL allowed characters and spaces.
 @param string @b (NSURL @b*) @a Encoded @a URL of API or Web Service.
 @return @b(NSURL* @b*).
  */
-(NSURL *)GetEncodedURL : (NSString *)string{
    NSLog(@"Encoded URL: %@",[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    return [NSURL URLWithString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] ;
}



#pragma HTTP Client

-(void)getDictionaryFromURLRequest:(NSMutableURLRequest *)request andCompletionHandler:(void (^)(NSDictionary *))completionHandler{
    
    // Create a data task object to perform the data downloading.
    NSURLSessionDataTask *task = [[self GetSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                      [[ProgressIndicator sharedInstance] Hide];
                                      if (nil != error)
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryWithStatusCode:520 andStatus:@"Error Occurred!" andMessage:[NSString stringWithFormat:@"Description: %@ and Failure Reason: %@",[error localizedDescription],[error localizedFailureReason]] andDictionary:nil]);}];
                                      
                                      if (200 != [(NSHTTPURLResponse *)response statusCode])
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryWithStatusCode:[(NSHTTPURLResponse *)response statusCode] andStatus:@"Error Occurred!" andMessage:@"Server is not responding at the moment. Please try again later." andDictionary:nil]);}];
                                      
                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryFromData:data]);}];
                                      
                                  }];
    
    [task resume];
    
}

-(void)getDictionaryAfterUploadingDataFromURLRequest:(NSMutableURLRequest *)request andData : (NSData *)data andCompletionHandler:(void (^)(NSDictionary *))completionHandler{
    

    NSURLSessionUploadTask *uploadTask = [[self GetSession] uploadTaskWithRequest:request
                                                               fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                                   [[ProgressIndicator sharedInstance] Hide];
                                                                   if (nil != error)
                                                                       [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryWithStatusCode:520 andStatus:@"Error Occurred!" andMessage:[NSString stringWithFormat:@"Description: %@ and Failure Reason: %@",[error localizedDescription],[error localizedFailureReason]] andDictionary:nil]);}];
                                                                   
                                                                   if (200 != [(NSHTTPURLResponse *)response statusCode])
                                                                       [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryWithStatusCode:[(NSHTTPURLResponse *)response statusCode] andStatus:@"Error Occurred!" andMessage:@"Server is not responding at the moment. Please try again later." andDictionary:nil]);}];
                                                                   
                                                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler([self DictionaryFromData:data]);}];
                                                               }];
    
    // 5
    [uploadTask resume];
    
    
}

-(void)getDataFromURLRequest:(NSMutableURLRequest *)request andCompletionHandler:(void (^)(NSData *))completionHandler{
    
    // Create a data task object to perform the data downloading.
    NSURLSessionDataTask *task = [[self GetSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                      [[ProgressIndicator sharedInstance] Hide];
                                      if (nil != error)
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler(nil);}];
                                      
                                      if (200 != [(NSHTTPURLResponse *)response statusCode])
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler(nil);}];
                                      
                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{ completionHandler(data);}];
                                      
                                  }];
    
    [task resume];
    
}


// Get NSURL Session
-(NSURLSession *)GetSession
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Ignoring Local Cache to download live data.
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    // Time out if server doesn't respond in 10 seconds.
    configuration.timeoutIntervalForRequest = 10.0;
    
    return  [NSURLSession sessionWithConfiguration:configuration];
}

// Parse JSON Data to Dictionary
-(NSDictionary *)DictionaryFromData : (NSData *)data{
    
    if(nil == data)
        return [self DictionaryWithStatusCode:250 andStatus:@"Error Occurred!" andMessage:@"Server is not responding with the desired respond." andDictionary:nil];
    
    NSError * error = nil;
    
    NSLog(@"Response: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSDictionary * parsedDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // If error occurs while parsing
    if(nil != error)
        return [self DictionaryWithStatusCode:240 andStatus:@"Error Occurred!" andMessage:[NSString stringWithFormat:@"Description: %@ and Failure Reason: %@",[error localizedDescription],[error localizedFailureReason]] andDictionary:nil];
    
    return [self DictionaryWithStatusCode:200 andStatus:@"OK!" andMessage:@"Data received successfully." andDictionary:parsedDictionary];
}

// Return Dictionary in Proper format.
-(NSDictionary *)DictionaryWithStatusCode : (NSInteger)code andStatus : (NSString *)status andMessage : (NSString *)message andDictionary : (NSDictionary *)dictionary
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithInteger:code] forKey:@"StatusCode"];
    [dict setValue:status forKey:@"Status"];
    [dict setValue:message forKey:@"Message"];
    [dict setValue:dictionary forKey:@"Data"];
    return dict;
}


@end
