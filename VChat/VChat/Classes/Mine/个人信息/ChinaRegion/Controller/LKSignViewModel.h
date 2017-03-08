//
//  LKSignViewModel.h
//  VChat
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKSignViewModel : RVMViewModel
@property (nonatomic, readonly) RACCommand *saveCommand;

@property (strong,nonatomic) NSString *signStr;
@end
