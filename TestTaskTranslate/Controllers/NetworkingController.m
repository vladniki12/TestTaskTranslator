//
//  NetworkingController.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "NetworkingController.h"
#import "ApiHeader.h"
#import "ApiTranslate.h"
#import <AFNetworking.h>

@implementation NetworkingController 



+ (id)sharedInstance {
    static NetworkingController* sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



-(void)requestForTranslate:(NSString*) text completionHandler:(void (^)(NSString* textTranslate)) completionHandler {
    NSString* url = [self generateUrlWith:text];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:url]];
    
    NSURL *URL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString* textTranslate = [responseObject objectForKey:@"text"][0];
        int сodeRequest = [[responseObject valueForKey:@"code"] intValue];
        if(completionHandler) {
        
            if(сodeRequest == 200)
                completionHandler(textTranslate);
            else
                completionHandler(@"Error");
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        
       if(error.code != -1009)
        completionHandler(@"Error");
    }];
    
    
}

-(NSString*)generateUrlWith:(NSString*) text {

    NSString* url = [API_URL_STRING stringByAppendingString: [ApiTranslate translate]];
    url = [[url stringByAppendingString:@"key="] stringByAppendingString:API_KEY];
    url = [url stringByAppendingString:@"&lang=en"];
    url = [[url stringByAppendingString:@"&text="] stringByAppendingString:text];
    
    
    
    return url;
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
