//
//  XXPayService.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayService.h"

@implementation XXPayService

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order  completion:(XXPayServiceResponseBlock)completion {
    
}

- (void)xx_payWithOrder:(id<XXPayOrderPaprameterProtocol>)order controller:(UIViewController * _Nullable)viewController completion:(XXPayServiceResponseBlock)completion {
    
}

- (BOOL)xx_handleOpenURL:(NSURL *)url {
    return YES;
}

- (BOOL)xx_registerApp:(NSString *)appid {
    return YES;
}

@end
