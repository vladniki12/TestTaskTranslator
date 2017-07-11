//
//  TableViewCell.h
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Translate+CoreDataClass.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *textTranslate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indecatorLoad;

@property (nonatomic) Translate* translate;

@end
