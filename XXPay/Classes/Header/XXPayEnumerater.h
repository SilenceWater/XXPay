//
//  XXPayEnumerater.h
//  Pods
//
//  Created by Monster . on 2020/6/29.
//

#ifndef XXPayEnumerater_h
#define XXPayEnumerater_h

/**
 * 支付类型
 *
 * XXPaymentTypeAliPay: 支付宝
 * XXPaymentTypeWXPay:微信
 * XXPaymentTypeUNPay:银联
 */
typedef NS_ENUM(NSUInteger, XXPaymentType) {
    XXPaymentTypeAliPay,
    XXPaymentTypeWXPay,
    XXPaymentTypeUNPay,
};


/**
* 支付类型
*
- XXPayStatusSuccess: 支付成功
- XXPayStatusPaying:处理中
- XXPayStatusFail:订单支付失败
- XXPayStatusRepeat: 重复请求
- XXPayStatusCancel: 用户取消
- XXPayStatusNetworkFail: 网络连接出错
- XXPayStatusOther: 其他错误
- XXPayStatusUninstall: 应用未安装
- XXPayStatusPaprameterError: 订单参数错误
- XXPayStatusUnknown: 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态,
*/
typedef NS_ENUM(NSUInteger, XXPayStatus) {
    XXPayStatusSuccess,
    XXPayStatusPaying,
    XXPayStatusFail,
    XXPayStatusRepeat,
    XXPayStatusCancel,
    XXPayStatusNetworkFail,
    XXPayStatusOther,
    XXPayStatusUninstall,
    XXPayStatusPaprameterError,
    XXPayStatusUnknown,
};







#endif /* XXPayEnumerater_h */
