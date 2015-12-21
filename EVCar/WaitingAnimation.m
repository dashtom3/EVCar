//
//  WaitingAnimation.m
//  EVCar
//
//  Created by 田程元 on 15/10/22.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "WaitingAnimation.h"
@interface WaitingAnimation(){
    NSArray *waitingLabelString;
    NSTimer *timer;
    NSArray *waitingLabelKind;
    int waitingLabelNum ;
    int waitingLabelKindNum;
}

@end
@implementation WaitingAnimation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithNum:(int)Num WithMainFrame:(CGRect)frame{
    self = [[[NSBundle mainBundle] loadNibNamed:@"WaitingAnimation" owner:nil options:nil] firstObject];
    CGRect waitingFrame;
    waitingFrame.size = CGSizeMake(160, 160);
    waitingFrame.origin.x = frame.size.width/2-80;
    waitingFrame.origin.y = frame.size.height/2-80;
    self.frame = waitingFrame;
    if(self){
        self.alpha = 0;
        waitingLabelString = [NSArray arrayWithObjects:@"中",@"中.",@"中..",@"中...",nil];
        waitingLabelKind = [NSArray arrayWithObjects:@"发送请求",@"获取信息", nil];
        waitingLabelKindNum = Num;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(waitingLabelAnimation) userInfo:nil repeats:true];
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 4.0;
    }
    return self;
}

-(void)waitingLabelAnimation{
    _waitingLabel.text = [NSString stringWithFormat:@"%@%@",waitingLabelKind[waitingLabelKindNum],waitingLabelString[waitingLabelNum]];
    if(waitingLabelNum>=3){
        waitingLabelNum = 0;
    }else{
        waitingLabelNum++;
    }
}
-(void)startAnimation{
    self.alpha = 1;
    [timer setFireDate:[[NSDate alloc]init]];
    [_waitingActivity startAnimating];
}
-(void)stopAnimation{
    self.alpha = 0;
    [_waitingActivity stopAnimating];
    [timer invalidate];
}
@end
