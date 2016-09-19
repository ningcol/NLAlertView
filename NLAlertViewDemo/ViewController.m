//
//  ViewController.m
//  NLAlertViewDemo
//
//  Created by ningcol on 9/19/16.
//  Copyright © 2016 ningcol. All rights reserved.
//

#import "ViewController.h"
#import "NLAlertView.h"

@interface ViewController ()<NLAlertViewDelegate>
@property (nonatomic, strong) NLAlertView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NLAlertView *)alertView{
    if (!_alertView) {
        _alertView = [NLAlertView alertViewRemindText:@"确定删除该内容？"];
        _alertView.delegate = self;
        
    }
    return _alertView;
}

- (IBAction)clickOne:(id)sender {
    [self.alertView show];
}

#pragma mark - QJAlertViewDelegate
-(void)clickAlertViewButton:(UIButton *)clickButton{
    
    if (clickButton.tag == NLAlertButtomIndexFirst) {
        NSLog(@"点击了第一个按钮");
    }else if(clickButton.tag == NLAlertButtomIndexFirst + 1){
        NSLog(@"点击了第二个按钮");
    }
    
    [self.alertView dismiss];
    
}


@end
