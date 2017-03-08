//
//  LKSignViewModel.m
//  VChat
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKSignViewModel.h"
@interface LKSignViewModel ()
@property (nonatomic, strong) RACCommand *saveCommand;
@end

@implementation LKSignViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.saveCommand = [[RACCommand alloc] initWithEnabled:[self validateNickName] signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:_signStr];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

-(RACSignal *)validateNickName{
    return  [RACObserve(self, signStr) map:^id(NSString *str) {
        return str.length>0?@(YES):@(NO);
    }];
}

@end
