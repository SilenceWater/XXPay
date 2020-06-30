//
//  XXPayment.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XXPayService.h"

NS_ASSUME_NONNULL_BEGIN

/// 支付调用类
@interface XXPayment : NSObject


/// 支付接口
/// @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
/// @param completion 结果响应回调
+ (void)xx_payWithOrder:(XXPayOrderBlock)orderBlock completion:(XXPayServiceResponseBlock)completion;



/// 支付接口
/// @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
/// @param viewController 控制器（银联需要，不建议传入当前控制器，有可能导致无法释放）
/// @param completion 结果响应回调
+ (void)xx_payWithOrder:(XXPayOrderBlock)orderBlock viewController:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion;



/// 当程序跳回来时候做的处理
/// @param url url
+ (BOOL)xx_handleOpenURL:(NSURL * _Nonnull)url;



/// 注册支付应用 (其实就微信需要)
/// @param appid appid
/// @param type 注册结果
+ (BOOL)xx_registerApp:(NSString *)appid payType:(XXPaymentType)type;

@end

NS_ASSUME_NONNULL_END
