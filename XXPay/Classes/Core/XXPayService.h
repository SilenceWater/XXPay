//
//  XXPayService.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "XXPayResponse.h"
#import "XXPayOrderPaprameterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
  10000 成功,
 -10001 处理中,
 -10002 订单支付失败,
 -10003 重复请求,
 -10004 用户取消,
 -10005 网络连接出错,
 -10006 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态,
 -10007 其他错误,
 -10008 应用未安装,
 -10009 参数错误
 */

typedef void(^XXPayOrderBlock)(id <XXPayOrderPaprameterProtocol> order);
/*! 回调block */
typedef void(^XXPayServiceResponseBlock)(XXPayResponse * _Nonnull response);

/// 支付服务基类
@interface XXPayService : NSObject

@property (nonatomic, copy) XXPayServiceResponseBlock payBlock;


/// 如果不集成银联的项目可以使用此方法
/// @param order 订单
/// @param completion 回调
- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order completion:(XXPayServiceResponseBlock)completion;

/// 如果项目有集成银联，可以使用此方法
/// @param order 订单
/// @param viewController 启动支付控件的 viewController
/// @param completion 回调
- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order controller:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion;

/// appDelegate里回调
/// @param url url
- (BOOL)xx_handleOpenURL:(NSURL *)url;

/// 注册你的app
/// @param appid appId
- (BOOL)xx_registerApp:(NSString *)appid;

@end

NS_ASSUME_NONNULL_END
