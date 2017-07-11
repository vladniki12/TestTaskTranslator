//
//  NetworkingController.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingController : NSObject <NSURLSessionDelegate>


+ (id)sharedInstance;

-(void)requestForTranslate:(NSString*) text completionHandler:(void (^)(NSString* textTranslate)) completionHandler ;

@end
