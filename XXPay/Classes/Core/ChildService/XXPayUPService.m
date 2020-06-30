//
//  XXPayUPService.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayUPService.h"
#import "UPPaymentControl.h"

static NSString * const kUPPayModeDebug = @"01";
static NSString * const kUPPayModeDis = @"00";
static NSString * const K_UPPAY_SCHEME = @"uppayresult";

@interface XXPayUPService ()

@property (nonatomic, strong) NSString *payMode;

@end

@implementation XXPayUPService

+ (instancetype)sharedInstance {
    static XXPayUPService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/// 如果不集成银联的项目可以使用此方法
/// @param order 订单
/// @param completion 回调
- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order completion:(XXPayServiceResponseBlock)completion {
    [self xx_payWithOrder:order controller:nil completion:completion];
}

/// 如果项目有集成银联，可以使用此方法
/// @param order 订单
/// @param viewController 控制器
/// @param completion 回调
- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order controller:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion {
    
    if (completion) {
        self.payBlock = completion;
    }
    if (![self isPaymentAppInstalled]) {
        XXPayResponse *response = [XXPayResponse new];
        response.code = -10008;
        response.msg = @"未安装银联App";
        
        if (completion) {
            completion(response);
        }
        return;
    }
    [[UPPaymentControl defaultControl]startPay:order.upPayOrder fromScheme:order.scheme mode:self.payMode viewController:viewController];
    
}

/// appDelegate里回调
/// @param url url
- (BOOL)xx_handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:K_UPPAY_SCHEME]) {
        [[UPPaymentControl defaultControl]handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            [self analysisResult:data code:code];
        }];
    }
    return YES;
}


- (BOOL)isPaymentAppInstalled {
    return [[UPPaymentControl defaultControl]isPaymentAppInstalled];
}

- (void)analysisResult:(NSDictionary *)result code:(NSString *)code {
    NSInteger respCode;
    NSString *msg;
    
    if ([code isEqualToString:@"success"]) {

        respCode = 10000;
        msg = @"支付成功";
    }else if ([code isEqualToString:@"fail"]){
        respCode = -10002;
        msg = @"支付失败";
    }else if ([code isEqualToString:@"cancel"]){
        respCode = -10004;
        msg = @"用户取消";
    }else{
        respCode = -10007;
        msg = @"其他错误";
    }
    XXPayResponse *response = [XXPayResponse new];
    response.msg = msg;
    response.code = respCode;
    response.data = result;
    
    if (self.payBlock) {
        self.payBlock(response);
    }
}

@end
