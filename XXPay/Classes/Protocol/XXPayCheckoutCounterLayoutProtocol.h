//
//  XXPayCheckoutCounterLayoutProtocol.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 收银台布局参数协议
@protocol XXPayCheckoutCounterLayoutProtocol <NSObject>

/*! 支付通道名称  */
@property (nonatomic, copy) NSString *channelTypeName;

/*! 支付类型  */
@property (nonatomic, copy) NSString *payType;

/*! 支付通道logo  */
@property (nonatomic, copy) NSString *logoUrl;

/*! 通道类型id  */
@property (nonatomic, strong) NSNumber *channelTypeId;

/*! 是否选中  */
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
