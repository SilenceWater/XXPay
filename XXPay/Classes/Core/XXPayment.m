//
//  XXPayment.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import "XXPayment.h"
#import "XXPayOrder.h"
#import "XXPayWXService.h"
#import "XXPayUPService.h"
#import "XXPayAliService.h"

@implementation XXPayment

/// 支付接口
/// @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
/// @param completion 结果响应回调
+ (void)xx_payWithOrder:(XXPayOrderBlock)orderBlock  completion:(XXPayServiceResponseBlock)completion {
    [self xx_payWithOrder:orderBlock viewController:nil completion:completion];
}



/// 支付接口
/// @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
/// @param viewController 控制器（银联需要，不建议传入当前控制器，有可能导致无法释放）
/// @param completion 结果响应回调
+ (void)xx_payWithOrder:(XXPayOrderBlock)orderBlock  viewController:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion {
    XXPayOrder *order = [XXPayOrder new];
    if (orderBlock) {
        orderBlock(order);
    }
    
    XXPayService *service;
    
    switch (order.payType) {
        case XXPaymentTypeWXPay:
            {
                service = [XXPayWXService sharedInstance];
            }
            break;
        case XXPaymentTypeAliPay:
            {
                service = [XXPayAliService sharedInstance];
            }
            break;
        case XXPaymentTypeUNPay:
            {
                service = [XXPayUPService sharedInstance];
            }
            break;
        default:
            {
                service = [XXPayWXService sharedInstance];
            }
            break;
    }
    [service xx_payWithOrder:order controller:viewController completion:completion];
}



/// 当程序跳回来时候做的处理
/// @param url url
+ (BOOL)xx_handleOpenURL:(NSURL * _Nonnull)url {
    if([url.scheme hasPrefix:@"wx"]){
        //微信
        return [[XXPayWXService sharedInstance] xx_handleOpenURL:url];
    }else if([url.host isEqualToString:@"uppayresult"]){
        //银联
        return [[XXPayUPService sharedInstance] xx_handleOpenURL:url];
    }else if([url.host isEqualToString:@"safepay"]){
        //支付宝
        return [[XXPayAliService sharedInstance] xx_handleOpenURL:url];
    }
    return YES;
}



/// 注册支付应用 (其实就微信需要)
/// @param appid appid
/// @param type 注册结果
+ (BOOL)xx_registerApp:(NSString *)appid payType:(XXPaymentType)type {
    XXPayService * service;
    switch (type) {
        case XXPaymentTypeUNPay:
            service = [XXPayWXService sharedInstance];
            break;
            
        case XXPaymentTypeAliPay:
            service = [XXPayAliService sharedInstance];
            break;
            
        case XXPaymentTypeWXPay:
            service = [XXPayUPService sharedInstance];
            break;
            
        default:
            service = [XXPayWXService sharedInstance];
            break;
    }
    
    return [service xx_registerApp:appid];
}

@end
