//
//  AutoTestViewController.m
//  Calendar
//
//  Created by lazy on 15-4-10.
//  Copyright (c) 2015年 lazy. All rights reserved.
//

#import "AutoTestViewController.h"
#import "DateGenerator.h"

@interface AutoTestViewController ()

@property (strong, nonatomic) IBOutlet UIButton *rtnButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *autoTestDate;
@property (strong, nonatomic) DateGenerator *dateGenerator;

@end

@implementation AutoTestViewController

- (void)viewDidLoad{
    
    _dateGenerator = [[DateGenerator alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Event Handler

- (IBAction)return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)start:(id)sender {
    _autoTestDate = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AutoTestDates" ofType:@"plist"]];
    [_tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_autoTestDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSArray *date = [_autoTestDate objectAtIndex:[indexPath row]];
    NSString *result = [self generateDateOnIndexPath:indexPath];
    cell.textLabel.text = result ? result : @"非法日期";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"输入日期是:%@年%@月%@日",date[0],date[1],date[2]];
    
    return cell;
}

#pragma mark - Logic Method
- (NSString *)generateDateOnIndexPath:(NSIndexPath *)indexPath{
    NSArray *date = [_autoTestDate objectAtIndex:[indexPath row]];
    NSArray *nextDate = [_dateGenerator generateNextDayWithYear:[date[0] integerValue] month:[date[1] integerValue] andDay:[date[2] integerValue]];
    if ([nextDate count] == 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"下一天是:%@年%@月%@日",nextDate[0],nextDate[1],nextDate[2]];
}

@end
