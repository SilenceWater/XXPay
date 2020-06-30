//
//  XXPayResponse.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 支付响应类
@interface XXPayResponse : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) id data;

@end

NS_ASSUME_NONNULL_END
