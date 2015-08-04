//
//  ViewController.m
//  RunningLED
//
//  Created by du phung cong on 8/4/15.
//  Copyright (c) 2015 duphungcong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin; // > ball radius
    int _numberOfBall;
    CGFloat _space; // > ball diameter;
    CGFloat _ballDiameter;
    NSTimer* _timer; // _ indicate instant variable
    int _lastOnLed;
    int _lastOnLedLeft;
    int _lastOnLedRight;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _ballDiameter = 24.0;
    _numberOfBall = 13;
    
    //[self checkSizeOfApp];
    //[self numberOfBallvsSpace];
    [self drawRowOfBalls:_numberOfBall];
    
    _lastOnLed = -1;
    _lastOnLedLeft = -1;
    _lastOnLedRight = -1;
    //_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLedLeftToRight) userInfo:nil repeats:true];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLedRightToLeft) userInfo:nil repeats:true];
    //_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLedCenterToTwoSide) userInfo:nil repeats:true];
    
}

- (void) runningLedLeftToRight {
    if(_lastOnLed != -1) {
        [self turnOffLed:_lastOnLed];
    }
    
    if(_lastOnLed != _numberOfBall - 1) {
        _lastOnLed++;
    }
    else {
        _lastOnLed = 0;
    }
    [self turnOnLed:_lastOnLed];
}

- (void) runningLedRightToLeft {
    if(_lastOnLed != -1) {
        [self turnOffLed:_lastOnLed];
    }
    else {
        _lastOnLed = _numberOfBall;
    }
    if(_lastOnLed != 0) {
        _lastOnLed--;
    }
    else {
        _lastOnLed = _numberOfBall - 1;
    }
    [self turnOnLed:_lastOnLed];
}

- (void) runningLedCenterToTwoSide {
    int centerLed1, centerLed2;
    if(_numberOfBall % 2 == 0) { // if _numberOfBall is even, led center are 02 led
        centerLed2 = _numberOfBall / 2;
        centerLed1 = centerLed2 - 1;
    }
    else { // led center id only 01 led
        centerLed2 = _numberOfBall / 2;
        centerLed1 = centerLed2;
    }
    
    if(_lastOnLedLeft != -1 && _lastOnLedRight != -1) {
        [self turnOffLed:_lastOnLedLeft];
        [self turnOffLed:_lastOnLedRight];
    }
    else {
        _lastOnLedLeft = centerLed1 + 1;
        _lastOnLedRight = centerLed2 - 1;
    }
    
    if(_lastOnLedLeft != 0 && _lastOnLedRight != _numberOfBall - 1) {
        _lastOnLedLeft--;
        _lastOnLedRight++;
    }
    else {
        _lastOnLedLeft = centerLed1;
        _lastOnLedRight = centerLed2;
    }
    [self turnOnLed:_lastOnLedLeft];
    [self turnOnLed:_lastOnLedRight];
    
}

- (void) turnOnLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if(view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

- (void) turnOffLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if(view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"grey"];
    }
}

- (void) placeBallAtX: (CGFloat) x
                andY: (CGFloat) y
             withTag: (int) tag {
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    
    //NSLog(@"w = %3.0f, h = %3.0f", ball.bounds.size.width, ball.bounds.size.height);
}

- (void) numberOfBallvsSpace {
    BOOL stop = false;
    int n =3;
    while(!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if(space < _ballDiameter) {
            stop = true;
        }
        else {
            NSLog(@"Number of ball %d, space between ball center %3.0f", n, space);
        }
        n++;
    }
}

- (CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) numberOfBall {
    return (self.view.bounds.size.width - 2 * _margin) / (numberOfBall - 1);
}

- (void) drawRowOfBalls: (int) numberOfBall {
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberOfBall];
    for(int i = 0; i < numberOfBall; i++) {
        [self placeBallAtX:(_margin + i * space)
                      andY:100
                   withTag:(i + 100)];
    }
}

- (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"x= %3.0f, y = %3.0f", size.width, size.height);
}

@end
