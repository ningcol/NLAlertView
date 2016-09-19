//
//  NLAlertView1.m
//  QiJi
//
//  Created by ningcol on 9/5/16.
//  Copyright © 2016 ningcol. All rights reserved.
//

#import "NLAlertView.h"


#define RGBCOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define COMMITBTN_HEIGHT 40
const static int buttonCount = 3;


@interface NLAlertView()
@property (nonatomic, strong) UIView      *hudView;
@property (nonatomic, strong) UILabel     *remindLabel;
// 遮罩
@property (nonatomic, strong) UIView      *maskView;
@property (nonatomic, strong) UIButton    *cancelBtn;



@end
@implementation NLAlertView


+(instancetype)alertViewRemindText:(NSString *)remindStr{
    
    return [[NLAlertView alloc] initWithRemindText:remindStr];
}
            
-(instancetype)initWithRemindText:(NSString *)remindStr{
    self = [super init];
    if (self) {
        //默认值
        self.remindText = remindStr;
        self.remindTextFontSize = 17;
        self.isHiddenCancelBtn = NO;
       
        
        self.hudViewSize = CGSizeMake(SCREEN_WIDTH - 50, 120);
        self.hudView.backgroundColor = RGBCOLOR(255, 255, 255, 0.3);
        
        
    }
    return self;
    
}


-(instancetype)init{
    self = [super init];
    if (self) {
        //默认值
        self.remindTextFontSize = 17;
        self.isHiddenCancelBtn = NO;
        
        self.hudViewSize = CGSizeMake(SCREEN_WIDTH - 50, 120);
        self.hudView.backgroundColor = RGBCOLOR(255, 255, 255, 0.3);
       
    

    }
    return self;
}


-(void)clickBtn:(UIButton *)buttom{
    if ([self.delegate respondsToSelector:@selector(clickAlertViewButton:)]) {
        [self.delegate clickAlertViewButton:buttom];
    }
}

#pragma mark - lazy init
-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
    }
    return _maskView;
}



-(UIView *)hudView{
    if (!_hudView) {
        _hudView = [[UIView alloc] init];
        //先设置大小，在设置center
        CGRect frame = _hudView.frame;
        frame.size = self.hudViewSize;
        _hudView.frame = frame;
        _hudView.center = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2);
        _hudView.layer.masksToBounds = YES;
        _hudView.layer.cornerRadius = 5;

        CGFloat margin = 20;
        
        //水平分隔线
        UIView *horiLine = [[UIView alloc] init];
        horiLine.frame = CGRectMake(margin/2, _hudView.frame.size.height-COMMITBTN_HEIGHT, _hudView.frame.size.width-margin, 1);
        horiLine.backgroundColor = [UIColor whiteColor];
        horiLine.alpha = 0.3;
        [self.hudView addSubview:horiLine];
        
        //判断是否有取消按钮
        if (self.isHiddenCancelBtn == NO) {
            for (int i=0; i < buttonCount; i++) {
                UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                commitBtn.tag = NLAlertButtomIndexFirst + i;
                commitBtn.frame = CGRectMake(i *(_hudView.frame.size.width/buttonCount), CGRectGetMaxY(horiLine.frame), _hudView.frame.size.width/buttonCount, COMMITBTN_HEIGHT);
                if (i==0) {
                    [commitBtn setTitle:@"取消" forState:UIControlStateNormal];
                    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    commitBtn.alpha = 0.7;
                }else{
                    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
                    [commitBtn setTitleColor:RGBCOLOR(239, 187, 86, 1) forState:UIControlStateNormal];
                }
                [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                [commitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_hudView addSubview:commitBtn];
                
                //垂直分隔线
                if (i + 1 >buttonCount) break;
                UIView *verLine = [[UIView alloc] init];
                verLine.frame = CGRectMake(_hudView.frame.size.width/buttonCount * (i + 1) ,  _hudView.frame.size.height-COMMITBTN_HEIGHT+margin/2, 1, COMMITBTN_HEIGHT-margin);
                verLine.backgroundColor = [UIColor whiteColor];
                verLine.alpha = 0.3;
                [self.hudView addSubview:verLine];

            }
        }else{  //没有取消按钮
            UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            commitBtn.tag = NLAlertButtomIndexFirst;
            commitBtn.frame = CGRectMake(0, CGRectGetMaxY(horiLine.frame), _hudView.frame.size.width, COMMITBTN_HEIGHT);
            
            [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
            [commitBtn setTitleColor:RGBCOLOR(239, 187, 86, 1) forState:UIControlStateNormal];
    
            [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [commitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_hudView addSubview:commitBtn];
        }
        
        self.remindLabel.frame = CGRectMake(0, (_hudView.frame.size.height-COMMITBTN_HEIGHT)/2 - 5, _hudView.frame.size.width, 20);
        
        [self.hudView addSubview:self.remindLabel];
    }
    return _hudView;
}




-(UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.backgroundColor = [UIColor clearColor];
        _remindLabel.textColor = [UIColor whiteColor];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.numberOfLines = 0;
        
    }
    return _remindLabel;
}


-(void)setRemindText:(NSString *)remindText{
    _remindText = remindText;
    self.remindLabel.text = remindText;
}

-(void)setRemindTextFontSize:(float)remindTextFontSize{
    _remindTextFontSize = remindTextFontSize;
    self.remindLabel.font = [UIFont systemFontOfSize:remindTextFontSize];
}
-(void)setHudViewBackgroundColor:(UIColor *)hudViewBackgroundColor{
    _hudViewBackgroundColor = hudViewBackgroundColor;
    self.hudView.backgroundColor = hudViewBackgroundColor;
}


-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.hudView];

    self.hudView.alpha = 0;
    self.maskView.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.hudView.transform = CGAffineTransformMakeScale(1, 1);
        self.hudView.alpha = 1;
        self.maskView.alpha = 0.8;
    }];
    
}

- (void)dismiss {
    [UIView animateWithDuration:.15 animations:^{
        self.hudView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.maskView.alpha = 0;
        self.hudView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.maskView removeFromSuperview];
            [self.hudView removeFromSuperview];
            
        }
    }];
}

@end
