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
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 135, 320, 210)];
        NSLog(@"frame %@",NSStringFromCGRect(self.frame));

        SKShapeNode *yourline = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
//        CGPathMoveToPoint(pathToDraw, NULL, 200, 200);
//        CGPathAddLineToPoint(pathToDraw, NULL, 0, 320);
        CGPathAddRect(pathToDraw, NULL, CGRectMake(0, 135, 320, 210));
        yourline.path = pathToDraw;
        [yourline setStrokeColor:[UIColor redColor]];
        
        
        background = [[Background alloc]init];
        [self addChild:background];

        backgroundCounter = 0;
        backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
        
        baby = [[IBBaby alloc]init];
        baby.position = CGPointMake(100, 250);
        baby.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:25];
        baby.physicsBody.dynamic = YES;
        baby.physicsBody.affectedByGravity = YES;
        [self addChild:baby];

        self.motionManager = [[CMMotionManager alloc] init];
        [self.motionManager startAccelerometerUpdates];
    
        [self addChild:yourline];

    }
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [baby.physicsBody applyForce:CGVectorMake(0, 10000)];
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
//    [self processUserMotionForUpdate:currentTime];
}

-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime {
    //1
    //    SKSpriteNode* ship = (SKSpriteNode*)[self childNodeWithName:kShipName];
    //2
    CMAccelerometerData* data = self.motionManager.accelerometerData;
    //3
    if (fabs(data.acceleration.x) > 0.2 || fabs(data.acceleration.y) > 0.2) {
        [baby.physicsBody applyForce:CGVectorMake(40.0 * data.acceleration.x, 40.0 * data.acceleration.y)];
    }
}

@end
