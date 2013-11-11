//
//  Background.h
//  Superbaby
//
//  Created by Felix Belau on 11.11.13.
//  Copyright (c) 2013 Belimi. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    STRAND = 0,
    MOUNT = 1,
    DORF = 2,
	HILL = 3,
    CITY = 4,
} BGType;

@interface Background : SKNode

@property (nonatomic) int bgtype;
@property (nonatomic) int newBgType;

-(void)update:(CFTimeInterval)currentTime;

-(void)generateBackground;
-(void)animateToNewBackground:(int)type;


@end
