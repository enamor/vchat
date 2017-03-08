//
//  UIView+Animation.m
//  VChat
//
//  Created by zhouen on 16/7/5.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
//移动到左上角
- (void)movetToLeftTopCorner
{
    CGPoint fromPoint = self.center;
    //路径曲线   --  简单介绍一下这个原生画图的方法
    /*UIBezierPath  贝塞尔曲线 -- UIBezierPath是CGPathRef数据类型的封装。如果是基于矢量形状的路径，都用直线和曲线去创建。我们使用直线段去创建矩形和多边形，使用曲线去创建圆弧（arc）、圆或者其他复杂的曲线形状。
     
     使用UIBezierPath画图步骤：
     创建一个UIBezierPath对象
     调用-moveToPoint:设置初始线段的起点
     添加线或者曲线去定义一个或者多个子路径
     改变UIBezierPath对象跟绘图相关的属性。如，我们可以设置画笔的属性、填充样式等
     */
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGSize size = CGSizeMake(self.frame.size.width*0.3, self.frame.size.height*0.25);
    CGPoint toPoint = CGPointMake(self.frame.size.width - (size.width/2.0), (size.height)/2.0);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x, toPoint.y)];
    
    //关键帧
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = movePath.CGPath;
    //    moveAnimation.fillMode = kCAFillModeForwards;
    //
    //    //removedOnCompletion 这个是一旦渲染时间结束后系统自动删除渲染效果
    moveAnimation.removedOnCompletion = NO;
    
    //旋转变化 / 缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x.y轴缩小到0.1 z轴不变；
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.25, 1)];
    scaleAnim.removedOnCompletion = NO;
    //    scaleAnim.fillMode = kCAFillModeForwards;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    //    opacityAnim.fillMode = kCAFillModeForwards;
    
    //关键帧、旋转、透明度组合起来执行
    CAAnimationGroup *anmiGroup = [CAAnimationGroup animation];
    //将上边的动态操作进行组合起来
    anmiGroup.animations = [NSArray arrayWithObjects:moveAnimation,scaleAnim,nil];
    anmiGroup.duration = 0.5;
    anmiGroup.fillMode = kCAFillModeForwards;
    [anmiGroup setAutoreverses:NO];
    anmiGroup.removedOnCompletion = NO;
    [self.layer addAnimation:anmiGroup forKey:nil];
    
}
@end
