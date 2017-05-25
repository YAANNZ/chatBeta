//
//  ViewController.m
//  02.聊天室
//
//  Created by ZHUYN on 2017/5/23.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController () <GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *field;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation ViewController

- (IBAction)connectToHostAction:(id)sender
{
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    NSError *err = nil;
    [self.clientSocket connectToHost:@"192.168.210.134" onPort:5288 error:&err];
    if (!err)
    {
        NSLog(@"连接发送成功");
    }
    else
    {
        NSLog(@"连接发送失败");
    }
}

- (IBAction)sendAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
