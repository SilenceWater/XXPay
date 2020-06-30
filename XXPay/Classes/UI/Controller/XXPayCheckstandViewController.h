//
//  XXPayCheckstandViewController.h
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import <UIKit/UIKit.h>
#import "XXPayCheckstandServiceDelegate.h"
#import "XXPayCheckoutCounterLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^DYPayConfigRowsInSectionBlock)(NSInteger section);
typedef void(^DYPayDeploymentCellBlock)(id<XXPayCheckoutCounterLayoutProtocol>celldeployment, NSInteger section, NSInteger row);

/// 收银台 Controller
@interface XXPayCheckstandViewController : UIViewController

- (instancetype)initWithLayoutNumberOfSections:(NSInteger)sections
                         numberOfRowsInSection:(DYPayConfigRowsInSectionBlock)rowsBlock
                               deploymentCells:(DYPayDeploymentCellBlock)deploymentCells NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/*! 金额 */
@property (nonatomic, copy) NSString *moneyTitle;

/*! 剩余支付时间（s）  */
@property (nonatomic, assign) NSInteger timeInterval;

/*! 订单号  */
@property (nonatomic, copy) NSString *orderNumber;

/*! 跳转schemes（非必填，有默认值）  */
@property (nonatomic, copy) NSString *scheme;

/*! 支付回调  */
@property (nonatomic, weak) id <XXPayCheckstandServiceDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
