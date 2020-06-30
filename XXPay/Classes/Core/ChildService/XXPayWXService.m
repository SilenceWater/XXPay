//
//  XXPayWXService.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayWXService.h"
#import <WechatOpenSDK/WXApi.h>

static NSString * const K_WXPAY_SCHEME = @"wx";

@interface XXPayWXService () <WXApiDelegate>

@end

@implementation XXPayWXService

+ (instancetype)sharedInstance {
    static XXPayWXService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order completion:(XXPayServiceResponseBlock)completion {
    [self xx_payWithOrder:order controller:nil completion:completion];
}

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order controller:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion {
    self.payBlock = completion;
    
    if (![self isWXAppInstalled]) {
        XXPayResponse *response = [XXPayResponse new];
        response.code = -10008;
        response.msg = @"应用未安装";
        
        if (completion) {
            completion(response);
        }
        
        return;
    }else if (![self isWXAppSupportApi]){
        
        XXPayResponse *response = [XXPayResponse new];
        response.code = -10008;
        response.msg = @"当前版本微信不支持支付";
        
        if (completion) {
            completion(response);
        }
        return;
    }
    
    NSAssert(order.partnerId.length ||
             order.prepayId.length ||
             order.nonceStr.length ||
             order.package.length ||
             order.sign.length,
             @"参数不能为空");
    
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = order.partnerId;
    req.prepayId = order.prepayId;
    req.nonceStr = order.nonceStr;
    req.timeStamp = order.timeStamp;
    req.package = order.package?:@"Sign=WXPay";
    req.sign = order.sign;
    
    BOOL sendResult = [WXApi sendReq:req];
    
     if (!sendResult) {
         XXPayResponse *response = [XXPayResponse new];
         response.code = -10002;
         response.msg = @"发送失败";
         
         if (completion) {
             completion(response);
         }
     }
    
}

- (BOOL)registerApp:(NSString *)appid {
   return [WXApi registerApp:appid];
}

- (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

- (BOOL)isWXAppSupportApi {
    return [WXApi isWXAppSupportApi];
}

//回调处理
- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.scheme hasPrefix:K_WXPAY_SCHEME]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

#pragma mark -
#pragma mark -  WXApiDelegate

- (void)onResp:(BaseResp*)resp {
    
    NSInteger code = 0;
    NSString *msg;
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp * response = (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                code = 10000;
                msg = @"成功（服务器端查询支付通知或查询API返回的结果再提示成功）";
                break;
                
                case WXErrCodeCommon:
                code = -10002;
                msg = @"支付失败，可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。";
                break;
                
                case WXErrCodeUserCancel:
                code = -10004;
                msg = @"用户取消";
                break;
                
                case WXErrCodeSentFail:
                code = -10002;
                msg = @"发送失败";
                break;
                
                case WXErrCodeAuthDeny:
                code = -10002;
                msg = @"授权失败";
                break;
                
                case WXErrCodeUnsupport:
                code = -10008;
                msg =  @"当前版本微信不支持支付";
                break;
                
                
            default:
                code = -10007;
                msg = @"其他错误";
                break;
        }
    }
    
    XXPayResponse *response = [XXPayResponse new];
    response.code = code;
    response.msg = msg;
    response.data = resp.errStr;
    
    if (self.payBlock) {
        self.payBlock(response);
    }
}


@end
