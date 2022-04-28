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
    NSDictionary *dict = [NSDictionary new];
    WechatPayService *wechatService = [[WechatPayService alloc]init:dict];
    NSString *url = @"https://cdc-dev.order.place/#/StoreList/latitude/22.3993429/longitude/114.19149120000002";
    NSMutableArray *services = [NSMutableArray new];
    [services addObject:wechatService];
    [OrderPlace openUrlWithCaller:self url:url options:dict services:services closeCB:nil];
}


@end
