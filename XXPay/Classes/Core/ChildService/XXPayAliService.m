//
//  XXPayAliService.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayAliService.h"
#import <AlipaySDK/AlipaySDK.h>

static NSString * const K_ALIPAY_HOST = @"safepay";

@implementation XXPayAliService

+ (instancetype)sharedInstance {
    static XXPayAliService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order completion:(XXPayServiceResponseBlock)completion {
    [self xx_payWithOrder:order controller:nil completion:completion];
}

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order controller:(UIViewController *)viewController completion:(XXPayServiceResponseBlock)completion {
    
    if (!order.aliPayOrder.length) {
        
        XXPayResponse *response = [XXPayResponse new];
        response.msg = @"订单信息不能为空";
        response.code = -10009;
        
        if (completion) {
            completion(response);
        }
        return;
    }
    
    if (!order.scheme.length) {
        
        XXPayResponse *response = [XXPayResponse new];
        response.msg = @"支付宝支付 schemes 为必填项";
        response.code = -10009;
        
        if (completion) {
            completion(response);
        }
        return;
    }
    
    if (completion) {
        self.payBlock = completion;
    }
    
    [[AlipaySDK defaultService]payOrder:order.aliPayOrder fromScheme:order.scheme callback:^(NSDictionary *resultDic) {
        [self analysisResult:resultDic];
    }];
    
}

- (void)analysisResult:(NSDictionary *)result {
    
    NSNumber * resultStatus = result[@"resultStatus"];
    
    NSInteger status = resultStatus.integerValue;
    NSString *msg;
    NSInteger code;

    if (status == 9000) {
        msg = @"成功";
        code = 10000;
    }else if (status == 8000){
        msg = @"处理中";
        code = -10001;
    }else if (status == 4000){
        msg = @"订单支付失败";
        code = -10002;
    }else if (status == 5000){
        msg = @"重复请求";
        code = -10003;
    }else if (status == 6001){
        msg = @"用户取消";
        code = -10004;
    }else if (status == 6002){
        msg = @"网络连接出错";
        code = -10005;
    }else if (status == 6004){
        code = -10006;
        msg = @"支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态";
    }else{
        code = -10007;
        msg = @"其它支付错误";
    }
    
    NSDictionary * data = result[@"result"];
    XXPayResponse *response = [XXPayResponse new];
    response.msg = msg;
    response.code = code;
    response.data = data;
    
    if (self.payBlock) {
        self.payBlock(response);
    }
 
}


- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:K_ALIPAY_HOST]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self analysisResult:resultDic];
        }];
    }
    return YES;
    
}


@end
