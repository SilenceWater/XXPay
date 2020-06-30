//
//  XXPayCheckstandViewController.m
//  Pods-XXPay_Example
//
//  Created by Monster . on 2020/6/29.
//

#import "XXPayCheckstandViewController.h"
#import <Masonry/Masonry.h>
#import <XXNetwork/XXNetwork.h>
#import "XXPayGenerateOrderLayoutModel.h"
#import "XXPayCheckoutCounterHeaderView.h"

static NSString *const kCellHeaderId   = @"com.dypay.checkoutCounter.header.cell.identifier";
static NSString *const kCellTopCellID  = @"com.dypay.checkoutCounter.top.cell.identifier";
static NSString *const kCellIdentifier = @"com.dypay.checkoutCounter.cell.identifier";
static NSString *const kCellMoreID     = @"com.dypay.checkoutCounter.more.cell.identifier";

static NSString *const kPayOtherMonthKey = @"kPayOtherMonthKey";
static NSString *const kPayUseNewCardKey = @"kPayUseNewCardKey";
static NSString *const kPayWeChartKey = @"kPayWeChartKey";
static NSString *const kPayAlipayKey = @"kPayAlipayKey";

@interface XXPayCheckstandViewController () <UITableViewDelegate, UITableViewDataSource, XXNetworkResponseProtocol>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *layoutArr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *paymentType;

@property (nonatomic, strong) UIButton *payButton;

@end

@implementation XXPayCheckstandViewController

#pragma mark -
#pragma mark - 👉 View Life Cycle 👈

- (instancetype)initWithLayoutNumberOfSections:(NSInteger)sections numberOfRowsInSection:(DYPayConfigRowsInSectionBlock)rowsBlock deploymentCells:(DYPayDeploymentCellBlock)deploymentCells {
    if (self = [super init]) {
        
        self.layoutArr = [[self.layoutArr subarrayWithRange:NSMakeRange(0, 1)] mutableCopy];
        
        for (NSInteger section = 0; section < sections; section++) {
            NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
            
            NSInteger rows = rowsBlock(section);
            for (NSInteger row = 0; row < rows; row++) {
                XXPayGenerateOrderLayoutModel *model = [XXPayGenerateOrderLayoutModel new];
                deploymentCells(model,section,row);
                [sectionArr addObject:model];
            }
            self.dataArr = sectionArr;
            __block NSMutableArray *arr = [[NSMutableArray alloc]init];
            [sectionArr enumerateObjectsUsingBlock:^(XXPayGenerateOrderLayoutModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = @{
                    @"ID" : kCellIdentifier,
                    @"H" : @(60),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
                    @"icon" : obj.logoUrl.length ? obj.logoUrl : @"",
                    @"title" : obj.channelTypeName.length ? obj.channelTypeName : @"",
                    @"detail" : @"",
                    @"tags" : @"",
                    @"font" : @17,
                    @"isTopCorner" : idx == 0 ? @1 : @0,
                    @"isSelected" : @(idx == 0 ? YES : NO),
        //            @"router" : kPayWeChartKey,
                };
                [arr addObject:dic];
            }];
            [self.layoutArr addObject:arr];
            
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.title.length && !self.navigationItem.title.length) {
        self.navigationItem.title = @"收银台";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviewsContraints];
    
//    __weak typeof(self) weakSelf = self;
//    self.interceptBackBlock = ^{
//        [weakSelf showBackTipAlert];
//    };
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self dy_setNavBarBackgroundColor:[UIColor whiteColor]];
//}

#pragma mark -
#pragma mark - 👉 Request 👈

//- (void)sendPayPlaceOrderRequest {
//    DYPayPlaceOrderRequest *request = [[DYPayPlaceOrderRequest alloc]init];
//    request.orderNumber = self.orderNumber;
//    request.payType = self.paymentType;
//    request.tag = kPayPlaceOrderRequestTag;
//    request.responseDelegate = self;
//    [request startRequest];
//}

#pragma mark -
#pragma mark - 👉 DYNetworkResponseProtocol 👈

//- (void)networkRequest:(DYNetworkRequest *)networkRequest succeedByResponse:(DYNetworkResponse *)response {
//    switch (response.requestTag) {
//        case kPayPlaceOrderRequestTag:
//            {
//                DYPayOrderParamModel * paramModel = [DYPayOrderParamModel mj_objectWithKeyValues:response.responseContentData];
//                [self payAction:paramModel];
//            }
//            break;
//
//        default:
//            break;
//    }
//}
//
//- (void)networkRequest:(DYNetworkRequest *)networkRequest failedByResponse:(DYNetworkResponse *)response {
//
//}

#pragma mark -
#pragma mark - 👉 UITableViewDelegate && data source 👈

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.layoutArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.layoutArr[indexPath.section][indexPath.row];
    NSNumber *H = [dic valueForKey:@"H"];
    return H.floatValue;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XXPayCheckoutCounterHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kCellHeaderId];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.layoutArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
    NSDictionary *dic = self.layoutArr[indexPath.section][indexPath.row];
    NSString *identifier = [dic valueForKey:@"ID"];
    NSString *title = [dic valueForKey:@"title"];
    NSString *detail = [dic valueForKey:@"detail"];
    NSNumber *isTopCorner = [dic valueForKey:@"isTopCorner"];
    NSNumber *isBottomCorner = [dic valueForKey:@"isBottomCorner"];
    NSString *icon = [dic valueForKey:@"icon"];
    NSNumber *isSelected = [dic valueForKey:@"isSelected"];
    if (isSelected.boolValue) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    UITableViewCellAccessoryType accessoryType = [[dic valueForKey:@"Accessory"] integerValue];
    UITableViewCellSeparatorStyle separatorStyle = [[dic valueForKey:@"separatorStyle"] integerValue];
    UITableViewCellSelectionStyle selectionStyle = [[dic valueForKey:@"selectionStyle"] integerValue];
    
    if ([identifier isEqualToString:kCellTopCellID]) {
        
//        DYPayCheckoutCounterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellTopCellID];
//        cell.titleLabel.attributedText = [self.moneyTitle.length ? self.moneyTitle : @"￥0.00" dy_conversionMoneyStringByFont:[UIFont dy_font18pt:DYFontBoldTypeMedium]];
//        if (isBottomCorner.boolValue) {
//            [cell.contentView addRoundingCorenrs:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(9, 9)];
//        }
//        cell.statcView.timeInterval = self.timeInterval;
//
//        return cell;
        
    }else if ([identifier isEqualToString:kCellIdentifier]) {
//        NSString *tags = [dic valueForKey:@"tags"];
//        DYPayCheckoutCounterSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//        cell.dy_accessoryType = accessoryType;
//        cell.selectionStyle = selectionStyle;
//        cell.dy_separatorInset = UIEdgeInsetsMake(0, 30+ kScreenHeightRatio(60), 0, 0);
//
//        [cell.iconImageView dy_setImageWithURL:[NSURL URLWithString:icon]];
////        cell.iconImageView.image = kImageNamed(@[@"dy_pay_ali",@"dy_pay_wx"][indexPath.row]);
//        cell.titleLabel.text = title;
//        cell.tagLabel.text = tags;
//        NSNumber *font = [dic valueForKey:@"font"];
//        if (font) {
//            cell.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font.floatValue];
//        }
//
//        if (isTopCorner.boolValue) {
//            [cell.contentView addRoundingCorenrs:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(9, 9)];
//        }
//
//        if (isBottomCorner.boolValue) {
//            [cell.contentView addRoundingCorenrs:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(9, 9)];
//        }
//
//        return cell;
        
    }else if ([identifier isEqualToString:kCellMoreID]) {
        
//        DYPayCheckoutCounterIconSubtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellMoreID];
//        cell.dy_accessoryType = accessoryType;
//        cell.selectionStyle = selectionStyle;
//        cell.dy_separatorStyle = separatorStyle;
//
//        if (isTopCorner.boolValue) {
//            [cell.contentView addRoundingCorenrs:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(9, 9)];
//        }
//        [cell.iconImageView dy_setImageWithURL:[NSURL URLWithString:icon]];
//        cell.titleLabel.text = title;
//        cell.detailLabel.text = detail;
//
//        return cell;
        
    }else {
        return nil;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.layoutArr[indexPath.section][indexPath.row];
    NSString *router = [dic valueForKey:@"router"];
    
    if ([router isEqualToString:kPayUseNewCardKey]) {
        
        /// 使用新卡
        
    }else if ([router isEqualToString:kPayOtherMonthKey]) {
        /// 其他付款方式
//        DYPayPaymentMethodViewController *vc = [[DYPayPaymentMethodViewController alloc]init];
//        [self presentPanModal:vc];
        
    }else if ([router isEqualToString:kPayWeChartKey]) {
        /// 微信支付
        
        
    }else if ([router isEqualToString:kPayAlipayKey]) {
        /// 支付宝支付
        
        
    }
    
    
}

#pragma mark -
#pragma mark - 👉 UIScrollViewDelegate 👈

#pragma mark -
#pragma mark - 👉 Event response 👈

/*! 点击支付  */
- (void)pressPayButtonAction:(UIButton *)btn {
    
//    [self sendPayPlaceOrderRequest];
    
//    DYPayAlertController *vc = [[DYPayAlertController alloc]init];
//    vc.titleLabel.text = @"余额不足，请使用其他支付方式";
//    vc.detailLabel.text = nil;
//    vc.aleryType = DYPayAlertTypeCancel;
//    [vc.cancelButton setTitle:@"返回收银台" forState:UIControlStateNormal];
//    [vc showFromController:self];
}

#pragma mark -
#pragma mark - 👉 Private Methods 👈
/*! 返回提醒  */
- (void)showBackTipAlert {
//    DYPayAlertController *vc = [[DYPayAlertController alloc]init];
//    vc.aleryType = DYPayAlertTypeBoth;
//    int hour = self.timeInterval/60/60 % 24;
//    int minutes = self.timeInterval/60 % 60;
//    vc.detailLabel.text = [NSString stringWithFormat:@"您的订单在%d小时%d分钟内未支付将被取消,请尽快完成支付",hour,minutes];
//    vc.commitBlock = ^{
//        [self dy_popWithPartControllerCount:1];
//    };
//    [vc showFromController:self];
}

//支付
//- (void)payAction:(DYPayOrderParamModel *)model {
//
//    weakSelf(weakSelf);
//    [DYPayment payWithOrder:^(id<DYPaymentParamProtocol>  _Nonnull order) {
//
//        if ([weakSelf.paymentType isEqualToString:@"ali"]) {
//            [weakSelf aliPayParam:order response:model];
//            order.payType = DYPaymentTypeAliPay;
//        }else if ([weakSelf.paymentType isEqualToString:@"wechat"]) {
//            [weakSelf wxPayParam:order response:model];
//            order.payType = DYPaymentTypeWXPay;
//        }
//
//        order.scheme = weakSelf.scheme?:[DYPayConfig shared].scheme;
//
//
//    } completion:^(NSDictionary * _Nonnull info) {
//        NSLog(@"error : %@",info);
//        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(payCheckstandService:completion:)]) {
//            NSMutableDictionary * result = info.mutableCopy;
//            result[@"orderNumber"] = weakSelf.orderNumber?:@"";
//            [weakSelf.delegate payCheckstandService:weakSelf completion:result];
//        }
//    }];
//}

//支付宝参数设置
//- (void)aliPayParam:(id<DYPaymentParamProtocol>  _Nonnull)order response:(DYPayOrderParamModel *)model {
//    order.aliPayOrder = model.paySign.aliPaySign;
//}

//微信参数设置
//- (void)wxPayParam:(id<DYPaymentParamProtocol>  _Nonnull)order response:(DYPayOrderParamModel *)model {
//    order.partnerId = model.paySign.partnerId;
//    order.prepayId = model.paySign.prepayId;
//    order.nonceStr = model.paySign.nonceStr;
//    order.timeStamp = [model.paySign.timeStamp intValue];
//    order.sign = model.paySign.sign;
//}

#pragma mark -
#pragma mark - 👉 Getters && Setters 👈

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:XXPayCheckoutCounterHeaderView.class forHeaderFooterViewReuseIdentifier:kCellHeaderId];
//        [_tableView registerClass:DYPayCheckoutCounterHeaderCell.class forCellReuseIdentifier:kCellTopCellID];
//        [_tableView registerClass:DYPayCheckoutCounterSelectCell.class forCellReuseIdentifier:kCellIdentifier];
//        [_tableView registerClass:DYPayCheckoutCounterIconSubtitleCell.class forCellReuseIdentifier:kCellMoreID];
    }
    return _tableView;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        [_payButton addTarget:self action:@selector(pressPayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

//- (void)setDataArr:(NSArray<DYPayCheckoutCounterLayoutProtocol> *)dataArr {
//    _dataArr = dataArr;
//    self.layoutArr = [[self.layoutArr subarrayWithRange:NSMakeRange(0, 1)] mutableCopy];
//    __block NSMutableArray *arr = [[NSMutableArray alloc]init];
//    [dataArr enumerateObjectsUsingBlock:^(id <DYPayCheckoutCounterLayoutProtocol> _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSDictionary *dic = @{
//            @"ID" : kCellIdentifier,
//            @"H" : @(kScreenHeightRatio(60)),
//            @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//            @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//            @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
//            @"icon" : obj.logoUrl ?: @"",
//            @"title" : obj.channelTypeName ?: @"",
//            @"detail" : @"",
//            @"tags" : @"",
//            @"isTopCorner" : idx == 0 ? @1 : @0,
//            @"isSelected" : @(idx == 0 ? YES : NO),
////            @"router" : kPayWeChartKey,
//        };
//        [arr addObject:dic];
//    }];
//    [self.layoutArr addObject:arr];
//    [self.tableView reloadData];
//}

- (NSMutableArray *)layoutArr {
    if (!_layoutArr) {
        _layoutArr = @[
            @[
                @{
                    @"ID" : kCellTopCellID,
                    @"H" : @(106),
                    @"icon" : @"",
                    @"title" : @"",
                    @"detail" : @"",
                    @"tags" : @"",
                    @"isBottomCorner" : @1,
                },
            ],
//            @[
//                @{
//                    @"ID" : kCellIdentifier,
//                    @"H" : @(kScreenHeightRatio(56)),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
//                    @"icon" : @"dy_pay_bank_EMS",
//                    @"title" : @"邮政银行储蓄卡（5698）",
//                    @"detail" : @"",
//                    @"tags" : @"满800减60元",
//                    @"isTopCorner" : @1,
//                    @"router" : @"",
//                },
//                @{
//                    @"ID" : kCellIdentifier,
//                    @"H" : @(kScreenHeightRatio(56)),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
//                    @"icon" : @"dy_pay_bank_ABC",
//                    @"title" : @"农业银行信用卡（5865）",
//                    @"detail" : @"",
//                    @"tags" : @"单单减最高99",
//                    @"router" : @"",
//                },
//                @{
//                    @"ID" : kCellMoreID,
//                    @"H" : @(kScreenHeightRatio(56)),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeDisclosureIndicator),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
//                    @"icon" : @"dy_pay_bank",
//                    @"title" : @"使用新卡支付",
//                    @"detail" : @"",
//                    @"tags" : @"",
//                    @"router" : kPayUseNewCardKey,
//                },
//                @{
//                    @"ID" : kCellMoreID,
//                    @"H" : @(kScreenHeightRatio(56)),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeDisclosureIndicator),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleNone),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
//                    @"icon" : @"",
//                    @"title" : @"其他付款方式",
//                    @"detail" : @"查看",
//                    @"tags" : @"",
//                    @"isBottomCorner" : @1,
//                    @"router" : kPayOtherMonthKey,
//                },
//            ],
            @[
                @{
                    @"ID" : kCellIdentifier,
                    @"H" : @(60),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
                    @"icon" : @"dy_pay_wechart",
                    @"title" : @"微信支付",
                    @"detail" : @"",
                    @"tags" : @"",
                    @"isTopCorner" : @1,
                    @"router" : kPayWeChartKey,
                },
                @{
                    @"ID" : kCellIdentifier,
                    @"H" : @(60),
//                    @"Accessory" : @(DYTableViewCellAccessoryTypeNone),
//                    @"separatorStyle" : @(DYTableViewCellSeparatorStyleSingleLineEqule),
//                    @"selectionStyle" : @(UITableViewCellSelectionStyleNone),
                    @"icon" : @"dy_pay_alipay",
                    @"title" : @"支付宝支付",
                    @"detail" : @"",
                    @"tags" : @"",
                    @"isBottomCorner" : @1,
                    @"router" : kPayAlipayKey,
                },
            ],
        ].mutableCopy;
    }
    return _layoutArr;
}

//- (NSString *)paymentType {
//    id <DYPayCheckoutCounterLayoutProtocol>obj = self.dataArr[self.tableView.indexPathForSelectedRow.row];
//    return obj.payType;
//}

//- (UILabel *)moneyTitleLabel {
//    DYPayCheckoutCounterHeaderCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    return cell.titleLabel;
//}

#pragma mark -
#pragma mark - 👉 SetupConstraints 👈

- (void)setupSubviewsContraints {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payButton];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-15);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        }
    }];
}

@end
