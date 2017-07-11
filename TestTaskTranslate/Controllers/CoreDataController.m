//
//  CoreDataController.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "CoreDataController.h"
#import "NetworkingController.h"
#import "Translate+CoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>


@implementation CoreDataController

@synthesize arrayTranslate;


+ (id)sharedInstance {
    static CoreDataController* sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"translate"];
        arrayTranslate = [[Translate MR_findAll] mutableCopy];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


-(void)clearDB {
   
    [Translate MR_truncateAll];
    [arrayTranslate removeAllObjects];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [_delegate updateTable];
}

-(void) addTextForTranslate:(NSString *)text {
    Translate* translate = [Translate MR_createEntity];
    translate.text = text;
    
    [arrayTranslate addObject:translate];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    if( _delegate ) {
        [_delegate updateTable];
    }
}
@end
