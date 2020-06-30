//
//  XXPayConfig.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 聚合支付配置类
@interface XXPayConfig : NSObject

+ (instancetype)sharedInstance;

/** 本地服务id */
@property (nonatomic, copy) NSString *serviceIdentifierKey;

/** app scheme */
@property (nonatomic, copy) NSString *scheme;


@end

NS_ASSUME_NONNULL_END
