//
//  XXPayUPService.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayService.h"

NS_ASSUME_NONNULL_BEGIN

/// 银联支付类
@interface XXPayUPService : XXPayService

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
