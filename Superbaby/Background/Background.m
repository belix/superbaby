//
//  Background.m
//  Superbaby
//
//  Created by Felix Belau on 11.11.13.
//  Copyright (c) 2013 Belimi. All rights reserved.
//

#import "Background.h"

@implementation Background{
    SKSpriteNode *background1;
    SKSpriteNode *background2;
    
    BOOL groundHasToChange;
    BOOL ground1HasToChange;
    BOOL newGroundHasOnly1Pic;
    int uebergang;
    int uebergangsCounter;
    
    SKTexture *uebergangTexture;
    SKTexture *standardTexture;
}

-(id)init{
    self = [super init];
    if (self) {
        
        self.bgtype = HILL;
        uebergangsCounter = 0;
        uebergang = 0;
        groundHasToChange = NO;
        ground1HasToChange = NO;
        newGroundHasOnly1Pic = NO;
        
        background1 = [SKSpriteNode spriteNodeWithImageNamed:@"Straße_neu.png"];
        background1.position = CGPointMake(320/2,220);
        [self addChild:background1];
        
        background2 = [SKSpriteNode spriteNodeWithImageNamed:@"Straße_neu.png"];
        background2.position = CGPointMake(320/2+480.5f,220);
        [self addChild:background2];
    }
    return self;
}

-(void)animateToNewBackground:(int)type{
    self.newBgType= type;
    uebergangTexture = [SKTexture textureWithImageNamed:[self getuebergangForType:self.newBgType]];
    standardTexture = [SKTexture textureWithImageNamed:[self getNormalTexforType:self.newBgType]];
    ground1HasToChange = background1.position.x < 240 ? YES : NO;
    groundHasToChange = YES;
}


-(NSString*)getuebergangForType:(int)type{
    NSString *string;
    if(self.bgtype == HILL && type == STRAND){
        string = @"Strand_anfang.png";
    }
    else if(self.bgtype == STRAND && type == HILL){
        string = @"Strand_ende.png";
    }
    else if(self.bgtype == HILL && type == MOUNT){
        string = @"berg_links.png";
    }
    else if(self.bgtype == MOUNT && type == HILL){
        string = @"Berg_rechts.png";
    }
    else if(self.bgtype == HILL && type == DORF){
        string = @"Dorf_zaun.png";
    }
    else if(self.bgtype == DORF && type == HILL){
        string = @"Straße_neu.png";
    }
    else if(self.bgtype == CITY && type == HILL){
        string = @"stadt-rechts.png";
    }
    else if(self.bgtype == HILL && type == CITY){
        string = @"stadt-links.png";
    }
    else{
        string = @"Straße_neu.png";
    }
    return string;
}
-(NSString*)getNormalTexforType:(int)type{
    NSString *string;
    if(self.bgtype == HILL && type == STRAND){
        string = @"Strand.png";
    }
    else if(self.bgtype == HILL && type == MOUNT){
        string = @"Berge_mitte.png";
    }
    else if(self.bgtype == HILL && type == DORF){
        string = @"Dorf_zaun.png";
    }
    else if(self.bgtype == HILL && type == CITY){
        string = @"stadt-mitte.png";
    }
    else{
        string = @"Straße_neu.png";
    }
    return string;
}

-(void)setTexture:(SKTexture*)texture forNode:(SKSpriteNode*)node atPosition:(CGPoint)pos{
    node.texture = texture;
    node.position = pos;
}

-(void)update:(CFTimeInterval)currentTime {
    
    
    if (true) {
        float PIXELS_PER_SECOND = 300;
        float c_offset = 1/60.0f * PIXELS_PER_SECOND;
        
        background1.position = CGPointMake(background1.position.x - c_offset, background1.position.y);
        background2.position = CGPointMake(background2.position.x - c_offset, background2.position.y);
    }

    
    //new background generation

    if (groundHasToChange) {
        if ((uebergang == 0)  && background1.position.x <= -240) {
            [self setTexture:uebergangTexture forNode:background1 atPosition:background1.position];
            uebergang = 1;
        }
        else if((uebergang == 0) && background2.position.x <= -240){
            [self setTexture:uebergangTexture forNode:background2 atPosition:background2.position];
            uebergang = 2;
        }
        if ((uebergang == 1)  && background2.position.x <= -240) {
            if(uebergangsCounter >= 2){
                groundHasToChange = NO;
                uebergangsCounter = 0;
                uebergang = 0;
            }
            else{
                uebergangsCounter++;
                [self setTexture:standardTexture forNode:background2 atPosition:background2.position];
                uebergang = 2;
                self.bgtype = self.newBgType;
            }
        }
        else if((uebergang == 2) && background1.position.x <= -240){
            if(uebergangsCounter >= 2){
                groundHasToChange = NO;
                uebergangsCounter = 0;
                uebergang = 0;
            }
            else{
                uebergangsCounter++;
                [self setTexture:standardTexture forNode:background1 atPosition:background1.position];
                uebergang = 1;
                self.bgtype = self.newBgType;
            }
        }
    }
    
    if (background1.position.x < -240) {
        background1.position = CGPointMake(background2.position.x+480.5f,220);
    }
    if (background2.position.x < -240) {
        background2.position = CGPointMake(background1.position.x+480.5f,220);
    }
}




@end
