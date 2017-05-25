//
//  serverListener.m
//  01.10086服务器
//
//  Created by ZHUYN on 2017/5/22.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "serverListener.h"
#import "GCDAsyncSocket.h"

@interface serverListener () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) NSMutableArray *clientSockets; // 存储所有的客户端socket对象

@end


@implementation serverListener

- (void)start
{
    // 1、服务器绑定端口
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    NSError *err = nil;
    [self.serverSocket acceptOnPort:5288 error:&err];
    if (err)
    {
        NSLog(@"端口开启失败");
    }
    else
    {
        NSLog(@"服务开启成功");
    }
}

// 2、监听客户端链接
- (void)socket:(GCDAsyncSocket *)serverSocket didAcceptNewSocket:(GCDAsyncSocket *)clientSocket
{
    // 3、保存局部变量，允许客户端建立连接
    [self.clientSockets addObject:clientSocket];
    
    NSLog(@"收到客户端连接请求%ld", self.clientSockets.count);

//    NSString *strM = @"欢迎来到10086在线服务，请选择下面的数字选择服务\n[0]在线充值\n[1]在线投诉\n[2]优惠信息\n[3]特殊服务\n[4]退出\n";
//    [clientSocket writeData:[strM dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    // 调用此方法，读取数据的代理方法才会调用
    [clientSocket readDataWithTimeout:-1 tag:0];
}

// 4、读取客户端的请求数据
- (void)socket:(GCDAsyncSocket *)clientSocket didReadData:(NSData *)data withTag:(long)tag
{
    NSString *readStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",readStr);
    
    [clientSocket readDataWithTimeout:-1 tag:0];
    
//     5、处理客户端的数据
//    NSString *responseStr = nil;
//    switch ([readStr intValue])
//    {
//        case 0:
//            responseStr = @"系统维护中...\n";
//            break;
//        case 1:
//            responseStr = @"系统维护中hah...\n";
//            break;
//        case 2:
//            responseStr = @"冲1w送1元\n";
//            break;
//        case 3:
//            responseStr = @"走你\n";
//            break;
//        case 4:
//            responseStr = @"拜拜\n";
//            break;
//        default:
//            responseStr = @"输入不合法，请重新输入\n";
//            break;
//    }
//    
//    [clientSocket writeData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//    
//    if ([readStr intValue] == 4)
//    {
//        [self.clientSockets removeObject:clientSocket];
//    }
    
    // 转发
    for (GCDAsyncSocket *socket in self.clientSockets)
    {
        if (socket != clientSocket)
        {
            [socket writeData:data withTimeout:-1 tag:0];
        }
    }
}


- (void)stop
{}


- (NSMutableArray *)clientSockets
{
    if (!_clientSockets)
    {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}

@end
