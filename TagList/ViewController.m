//
//  ViewController.m
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ViewController.h"
#import "ZLTagListView.h"

#define kMainScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kMainScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UITextFieldDelegate>
{
    IBOutlet UITextField *_textField;
    ZLTagListView *_tagListView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTagListView];
}

- (void)createTagListView
{
    _tagListView = [[ZLTagListView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 40, 10) tagTitles:@"Foo,Tag Label 1,Tag Label 2"];
    _tagListView.center = self.view.center;
    _tagListView.tagBgColor = [UIColor colorWithRed:0.18 green:0.64 blue:0.37 alpha:1];
    _tagListView.tagTitleColor = [UIColor whiteColor];
    
    typeof(ViewController) *weakSelf = self;
    [_tagListView setClickAction:^(NSString *title) {
        [weakSelf showAlertView:[NSString stringWithFormat:@"click %@", title]];
    }];
    
    [self.view addSubview:_tagListView];
}

- (IBAction)btnClick:(id)sender
{
    [self.view endEditing:YES];
    [_tagListView addTagTitle:_textField.text];
}

- (IBAction)btnDelete:(id)sender
{
    [self.view endEditing:YES];
    [_tagListView deleteTagTitle:_textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - utils
- (void)showAlertView:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
