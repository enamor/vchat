//
//  LKRandomView.m
//  VChat
//
//  Created by zhouen on 16/9/22.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKRandomChatView.h"

@interface LKRandomChatView ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *photoWall;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) UIView *centerView;

@property (nonatomic, assign) int currentItem;
@end

static NSString *reuserIdentifer = @"random";
@implementation LKRandomChatView

-(void)awakeFromNib{
    [super awakeFromNib];
    _currentItem = 3;
    [self _initSubview];
}

-(void)_initSubview{
    
    [self.photoWall sd_setImageWithURL:[NSURL URLWithString:@"http://image.tianjimedia.com/uploadImages/2014/316/42/6L37248XXNPT.jpg"]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuserIdentifer];
    
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 20;
    self.flowLayout.itemSize = CGSizeMake(40 , 40);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //中间红圈
    UIView *centerView = [[UIView alloc] init];
    [self addSubview:centerView];
    self.centerView = centerView;
    centerView.backgroundColor = [kLuckThemeColor colorWithAlphaComponent:0.8];
    
    //毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //毛玻璃view视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.photoWall.bounds;
    [self.photoWall addSubview:effectView];
    effectView.alpha = .7f;
    
    
}

- (IBAction)didClickedStopBtn:(id)sender {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _centerView.frame = CGRectMake(kLuckScreenWidth/2.0 - 30, _collectionView.top, _collectionView.height, _collectionView.height);
    _centerView.layer.cornerRadius = 30;
    _centerView.layer.masksToBounds = YES;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1000;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hhhhh");
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserIdentifer forIndexPath:indexPath];
    if (indexPath.item %2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor blueColor];
    }
    if (indexPath.row == 4) {
        
    }
    
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    return cell;
    
}
-(void)randomAnimation{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:++_currentItem inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

-(void)startRrandomAnimation{
    if (_timer) {
        [self stopRrandomAnimation];
    }
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(randomAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

-(void)stopRrandomAnimation{
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
}

@end
