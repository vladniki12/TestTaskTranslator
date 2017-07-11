//
//  TableViewCell.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    _text.layer.borderColor = [UIColor blackColor].CGColor;
    _text.layer.borderWidth = 1.0;
    
    _textTranslate.layer.borderColor = [UIColor blackColor].CGColor;
    _textTranslate.layer.borderWidth = 1.0;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)changedTranslate:(NSNotification*) notification {
    
}




@end
