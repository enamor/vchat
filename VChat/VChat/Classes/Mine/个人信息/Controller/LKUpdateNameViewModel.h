//
//  LKUpdateNameViewModel.h
//  VChat
//
//  Created by zhouen on 16/8/30.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKUpdateNameViewModel : RVMViewModel
@property (nonatomic, readonly) RACCommand *saveCommand;

@property (strong,nonatomic) NSString *nickName;


@end
