//
//  XXPayCheckoutCounterHeaderView.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/30.
//

#import "XXPayCheckoutCounterHeaderView.h"
#import <Masonry/Masonry.h>

@interface XXPayCheckoutCounterHeaderView ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation XXPayCheckoutCounterHeaderView

#pragma mark -
#pragma mark - 👉 View Life Cycle 👈

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark -
#pragma mark - 👉 Request 👈

#pragma mark -
#pragma mark - 👉 DYNetworkResponseProtocol 👈

#pragma mark -
#pragma mark - 👉 <#Delegate#> 👈

#pragma mark -
#pragma mark - 👉 UIScrollViewDelegate 👈

#pragma mark -
#pragma mark - 👉 Event response 👈

#pragma mark -
#pragma mark - 👉 Private Methods 👈

#pragma mark -
#pragma mark - 👉 Getters && Setters 👈

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bgView;
}

#pragma mark -
#pragma mark - 👉 SetupConstraints 👈

- (void)setupSubviewsContraints {
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


@end
