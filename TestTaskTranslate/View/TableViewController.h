//
//  TableViewController.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataController.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,CoreDataControllerDelegat>

-(void)updateTable ;
-(void)updateTable:(NSNotification*) notification;

@end
