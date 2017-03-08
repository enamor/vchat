//
//  UserModel.m
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(NSDictionary *)descriptionDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (_account && _password && _AESKey) {
        [dict setValue:_account forKey:@"account"];
        [dict setValue:_password forKey:@"password"];
        [dict setValue:_AESKey forKey:@"AESKey"];
    }
    if (_accountType) {
        [dict setValue:@(_accountType) forKey:@"accountType"];
    }else{
        [dict setValue:@(0) forKey:@"accountType"];
    }
    return dict;
}
@end
