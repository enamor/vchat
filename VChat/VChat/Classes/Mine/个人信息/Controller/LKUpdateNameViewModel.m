//
//  LKUpdateNameViewModel.m
//  VChat
//
//  Created by zhouen on 16/8/30.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKUpdateNameViewModel.h"
@interface LKUpdateNameViewModel ()
@property (nonatomic, strong) RACCommand *saveCommand;
@end

@implementation LKUpdateNameViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.saveCommand = [[RACCommand alloc] initWithEnabled:[self validateNickName] signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:_nickName];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

-(RACSignal *)validateNickName{
    return  [RACObserve(self, nickName) map:^id(NSString *usernameText) {
        
        NSUInteger length = usernameText.length;
        
        if (length >= 1 && length <= 5) {
            return @(YES);
        }
        return @(NO);
    }];
    
//    return [RACSignal combineLatest:@[RACObserve(self, nickName)] reduce:^id(NSString *nickName){
//        return @(nickName.length > 0 && nickName.length < 10);
//    }];
}
@end
