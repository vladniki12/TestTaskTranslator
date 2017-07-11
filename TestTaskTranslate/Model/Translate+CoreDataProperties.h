//
//  Translate+CoreDataProperties.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "Translate+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Translate (CoreDataProperties)

+ (NSFetchRequest<Translate *> *)fetchRequest;

@property (nonatomic) int32_t idTranslate;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *textTranslate;

@end

NS_ASSUME_NONNULL_END
