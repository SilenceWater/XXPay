//
//  XXViewController.m
//  XXPay
//
//  Created by Monster . on 06/29/2020.
//  Copyright (c) 2020 Monster .. All rights reserved.
//

#import "XXViewController.h"
#import <XXPay/XXPay.h>
#import <Masonry/Masonry.h>

@interface XXViewController ()

@property (nonatomic, strong) UIButton *payButton;

@end

@implementation XXViewController


#pragma mark -
#pragma mark - 👉 View Life Cycle 👈

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviewsContraints];
}

#pragma mark -
#pragma mark - 👉 Request 👈

#pragma mark -
#pragma mark - 👉 DYNetworkResponseProtocol 👈

#pragma mark -
#pragma mark - 👉 UITableViewDelegate && data source 👈

#pragma mark -
#pragma mark - 👉 Event response 👈

- (void)pressPayButtonAction:(UIButton *)btn {
    
    [XXPayment xx_payWithOrder:^(id<XXPayOrderPaprameterProtocol>  _Nonnull order) {
        
    } completion:^(XXPayResponse * _Nonnull response) {
        
    }];
}

#pragma mark -
#pragma mark - 👉 Private Methods 👈

#pragma mark -
#pragma mark - 👉 Getters && Setters 👈

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = [UIColor cyanColor];
        [_payButton addTarget:self action:@selector(pressPayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

#pragma mark -
#pragma mark - 👉 SetupConstraints 👈

- (void)setupSubviewsContraints {
    [self.view addSubview:self.payButton];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
}

@end
