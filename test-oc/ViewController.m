//
//  ViewController.m
//  test-oc
//
//  Created by 陈培爵 on 2022/4/28.
//

#import "ViewController.h"
#import <OrderPlaceSdkPrd/OrderPlaceSdkPrd-Swift.h>
#import "test_oc-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)open:(id)sender {
    
    
    NSMutableDictionary *member = [NSMutableDictionary new];
    [member setValue:@"memberId" forKey:@"memberId"];
    [member setValue:@"session" forKey:@"session"];
    [member setValue:@"cdc" forKey:@"source"];
    [member setValue:@"zh" forKey:@"language"];
    [member setValue:@"99993212" forKey:@"octopusNo"];
    [member setValue:@"name" forKey:@"name"];
    [member setValue:@"M" forKey:@"gender"];
    [member setValue:@"23" forKey:@"age"];
    [member setValue:@"87654321" forKey:@"phone"];
    [member setValue:@"membersemail@email.com" forKey:@"email"];
    
    NSMutableArray *systemOpenUrls = [NSMutableArray new];
    [systemOpenUrls addObject:@"octopus://"];
    [systemOpenUrls addObject:@"alipay://"];
    [systemOpenUrls addObject:@"alipays://"];
    [systemOpenUrls addObject:@"alipayhk://"];
    [systemOpenUrls addObject:@"https://itunes.apple.com"];
    [systemOpenUrls addObject:@"tel:"];
    [systemOpenUrls addObject:@"mailto:"];
    [systemOpenUrls addObject:@"itms-apps://itunes.apple.com"];
    [systemOpenUrls addObject:@"https://apps.apple.com"];

    NSMutableDictionary *options = [NSMutableDictionary new];
    [options setValue:@"features" forKey:@"scan,gps,applepay"];
    [options setValue:@"scan,gps,applepay" forKey:@"features"];
    [options setValue:member forKey:@"member"];
    [options setValue:@"your apple Merchant Identifier" forKey:@"appleMerchantIdentifier"];
    [options setValue:@"cdcAlipayScheme" forKey:@"alipayScheme"];
    [options setValue:@YES forKey:@"disableScroll"];
    [options setValue:systemOpenUrls forKey:@"systemOpenUrl"];
    
    WechatPayService *wechatService = [[WechatPayService alloc]init:options];
    NSString *url = @"https://cdc-dev.order.place/#/StoreList/latitude/22.3993429/longitude/114.19149120000002";
    NSMutableArray *services = [NSMutableArray new];
    [services addObject:wechatService];
    [OrderPlace openUrlWithCaller:self url:url options:options services:services closeCB:nil];
}


@end
