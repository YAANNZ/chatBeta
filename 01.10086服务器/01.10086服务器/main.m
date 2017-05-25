//
//  main.m
//  01.10086服务器
//
//  Created by ZHUYN on 2017/5/22.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "serverListener.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        // 开启10086服务
        serverListener *server = [[serverListener alloc] init];
        [server start];
        
        // 让程序不死(开启主运行循环)
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
