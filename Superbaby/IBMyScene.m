//
//  IBMyScene.m
//  Superbaby
//
//  Created by Felix Belau on 11.11.13.
//  Copyright (c) 2013 Belimi. All rights reserved.
//

#import "IBMyScene.h"
#import "Background.h"
#import "IBBaby.h"

@implementation IBMyScene{
    IBBaby *baby;
    Background *background;
    int backgroundCounter;
    NSTimer *backgroundTimer;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        background = [[Background alloc]init];
        [self addChild:background];

        backgroundCounter = 0;
        backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
        
        baby = [[IBBaby alloc]init];
        baby.position = CGPointMake(100, 200);
        [self addChild:baby];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
    }
}

-(void)changeBackground{
    if (background.bgtype == HILL) {
        
        int type = (backgroundCounter + 1) % 5;
        [background animateToNewBackground:type];
    }
    else{
        [background animateToNewBackground:HILL];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    [background update:currentTime];
    /* Called before each frame is rendered */
}

@end
