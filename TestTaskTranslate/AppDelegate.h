//
//  AppDelegate.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

