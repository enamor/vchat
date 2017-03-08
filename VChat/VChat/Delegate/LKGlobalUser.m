//
//  LKGlobalUser.m
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKGlobalUser.h"
#import "NSObject+LKProperty.h"


@implementation LKGlobalUser
+ (LKGlobalUser *)shareInstance
{
    static LKGlobalUser *globalUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalUser = [[LKGlobalUser alloc] init];
        
        id obj = [NSUserDefaults unarchiveObjectForKey:kGlobalUser];
        if (obj) {
            [globalUser reflectDataFromOtherObject:obj];
        }
        
    });
    return globalUser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initializeObserver];
    }
    return self;
}
-(void)_initializeObserver{
    int skip = [NSUserDefaults unarchiveObjectForKey:kGlobalUser]?2:1;
    
    //uid = 0 token=nil 未登录不需要归档
    [[[[RACObserve(self, uid) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return [value longValue]> 0;
    }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
    }];
    
    [[[[RACObserve(self, token) distinctUntilChanged] skip:skip]
     filter:^BOOL(NSString *value) {
         return value!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    
    [[[[RACObserve(self, headThumb) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, nickName) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, sex) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, birthday) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, province) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, city) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, area) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
    [[[[RACObserve(self, signature) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _token!=nil;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:kGlobalUser];
     }];
}

-(void)updateGlobalUserByDict:(NSDictionary *)dict{
    [self reflectDataFromOtherObject:dict];
}

-(void)clearGlobalUser{
    [self clearPropertyValue];
    [NSUserDefaults removeObjectForKey:kGlobalUser];
}


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self mj_encode:encoder];
}
@end
