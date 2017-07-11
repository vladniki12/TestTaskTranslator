//
//  Translate+CoreDataProperties.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "Translate+CoreDataProperties.h"

@implementation Translate (CoreDataProperties)

+ (NSFetchRequest<Translate *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Translate"];
}

@dynamic idTranslate;
@dynamic text;
@dynamic textTranslate;

@end
