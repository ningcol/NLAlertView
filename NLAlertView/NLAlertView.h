//
//  QJAlertView1.h
//  QiJi
//
//  Created by ningcol on 9/5/16.
//  Copyright © 2016 ningcol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NLAlertButtomIndex){
    NLAlertButtomIndexFirst = 80000,
};

@protocol NLAlertViewDelegate <NSObject>
-(void)clickAlertViewButton:(UIButton *)clickButton;
@end

@interface NLAlertView : UIView
/**提醒文字*/
@property (nonatomic, copy)   NSString *remindText;
/**提醒文字大小*/
@property (nonatomic, assign) float remindTextFontSize;
/**提示框背景颜色*/
@property (nonatomic, strong) UIColor *hudViewBackgroundColor;
/**提示框大小*/
@property (nonatomic, assign) CGSize   hudViewSize;
/**是否隐藏取消按钮*/
@property (nonatomic, assign) BOOL isHiddenCancelBtn;


-(void)show;
-(void)dismiss;


/**
 *  带有提醒文字的alertView
 *
 *  @param remindStr 提示文字
 */
+(instancetype)alertViewRemindText:(NSString *)remindStr;  //默认为有取消按钮的alerView

@property (nonatomic, weak)id<NLAlertViewDelegate> delegate;

@end
