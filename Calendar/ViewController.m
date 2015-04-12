//
//  ViewController.m
//  Calendar
//
//  Created by lazy on 15-4-9.
//  Copyright (c) 2015年 lazy. All rights reserved.
//

#import "ViewController.h"
#import "DateGenerator.h"

@interface ViewController (){
    id firstResponder;
    BOOL isLegal;
}

@property (strong, nonatomic) IBOutlet UITextField *year;
@property (strong, nonatomic) IBOutlet UITextField *month;
@property (strong, nonatomic) IBOutlet UITextField *day;
@property (strong, nonatomic) IBOutlet UILabel *nextDay;

@property (strong, nonatomic) DateGenerator *dateGenerator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateGenerator = [[DateGenerator alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Event Handler

- (IBAction)calculateNextDay:(id)sender {
    // Year: 1800-2100
    // Month: 1-12
    // Day: 1-31
    [firstResponder resignFirstResponder];
    NSString *result;
    NSArray *resultArr = [_dateGenerator generateNextDayWithYear:[[_year text] integerValue] month:[[_month text] integerValue] andDay:[[_day text] integerValue]];
    if ([resultArr count] == 0) {
        [self handleIllegalDate];
        return;
    } else {
        result = [NSString stringWithFormat:@"%@年%@月%@日",resultArr[0],resultArr[1],resultArr[2]];
    }
    
    _nextDay.text = result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)handleIllegalDate{
    isLegal = NO;
    [self showAlertWithMessage:@"非法日期"];
}

- (void)showAlertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UITextField
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    firstResponder = textField;
}

@end
