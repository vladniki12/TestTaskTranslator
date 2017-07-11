//
//  CoreDataController.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoreDataControllerDelegat;

@interface CoreDataController : NSObject

@property (nonatomic, retain) NSMutableArray* arrayTranslate;



+ (id)sharedInstance;

@property (nonatomic) id<CoreDataControllerDelegat> delegate;

-(void)addTextForTranslate:(NSString*)  text;
-(void)clearDB;


@end
@protocol CoreDataControllerDelegat
@required -(void)updateTable;
@end
