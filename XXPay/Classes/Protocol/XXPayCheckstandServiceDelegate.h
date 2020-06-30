//
//  XXPayCheckstandServiceDelegate.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XXPayResponse;

/// 收银台服务代理
@protocol XXPayCheckstandServiceDelegate <NSObject>

/**
 支付结果
 
 @param controller controller
 @param param 支付回调
 */
- (void)payCheckstandService:(UIViewController *_Nonnull)controller completion:(XXPayResponse *_Nonnull)response;

@end

NS_ASSUME_NONNULL_END
