//
//  TableViewController.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "NetworkingController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CoreDataController* coredataController = [CoreDataController sharedInstance];
    coredataController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable:) name:@"UPDTAE_TABLE" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CoreDataController sharedInstance] arrayTranslate] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    Translate* translate = [[CoreDataController sharedInstance] arrayTranslate][indexPath.row];
    
    cell.text.text = translate.text;
    
        if(!translate.textTranslate) {
        [[NetworkingController sharedInstance] requestForTranslate:translate.text completionHandler:^(NSString* textTranslate){
            translate.textTranslate = textTranslate;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [self updateTable];
        }];
        cell.textTranslate.text = @"";
        [cell.indecatorLoad startAnimating];
    } else {
        cell.textTranslate.hidden = NO;
        cell.textTranslate.text = translate.textTranslate;
        cell.indecatorLoad.hidden = YES;
        [cell.indecatorLoad stopAnimating];
    }
    
    return cell;
}

-(void)updateTable {
    [_tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath* indexPath;
        if(([self.tableView numberOfRowsInSection:([self.tableView numberOfSections]-1)]-1) < 0) {
            return;
        } else {
            indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:([self.tableView numberOfSections]-1)]-1  inSection:([self.tableView numberOfSections]-1)];
        }
        
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

-(void)updateTable:(NSNotification*) notification {
    
    [self updateTable];
}


@end
