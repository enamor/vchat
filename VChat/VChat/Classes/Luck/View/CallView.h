//
//  CallView.h
//  VChat
//
//  Created by zhouen on 16/7/6.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallView : UIView

-(void)beginToCall;
-(void)backOriginalState;

- (BOOL)startReading;
- (void)stopReading;
@end
