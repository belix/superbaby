//
//  IBBaby.m
//  Superbaby
//
//  Created by Felix Belau on 11.11.13.
//  Copyright (c) 2013 Belimi. All rights reserved.
//

#import "IBBaby.h"

@implementation IBBaby{
    SKSpriteNode *bottomFire1;
    SKSpriteNode *bottomFire2;
    SKSpriteNode *leftFire;
    SKSpriteNode *bottle;
    SKSpriteNode *babyCorpus;
}

-(id)init{
    self = [super init];
    if (self) {
        bottomFire1 = [SKSpriteNode spriteNodeWithImageNamed:@"flamme-unten_kleiner.png"];
        bottomFire1.alpha = 0.0f;
        bottomFire1.position = CGPointMake(-17,-13);
        [self addChild:bottomFire1];
        
        bottomFire2 = [SKSpriteNode spriteNodeWithImageNamed:@"flamme-unten_kleiner.png"];
        bottomFire2.alpha = 0.0f;
        bottomFire2.position = CGPointMake(6,-13);
        [self addChild:bottomFire2];
        
        leftFire = [SKSpriteNode spriteNodeWithImageNamed:@"flamme-hinten1_kleiner.png"];
        leftFire.position = CGPointMake(-46,1);
        [self addChild:leftFire];
        
        bottle = [SKSpriteNode spriteNodeWithImageNamed:@"flasche_kleiner.png"];
        [self addChild:bottle];
        
        babyCorpus = [SKSpriteNode spriteNodeWithImageNamed:@"baby_kleiner.png"];
        babyCorpus.position = CGPointMake(0,18);
        [self addChild:babyCorpus];
        
        [self animateLeftFire];
    }
    return self;
}



-(void)animateLeftFire{
    NSMutableArray* textures = [NSMutableArray arrayWithCapacity:5];
    for (int i = 1; i < 4; i++) {
        SKTexture* texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"flamme-hinten%i_kleiner.png",i]];
        [textures addObject:texture];
    }
    
    [leftFire runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:textures
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]] withKey:@"animateLeftFire"];
    
    return;
}



@end
