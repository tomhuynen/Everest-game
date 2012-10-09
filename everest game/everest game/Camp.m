//
//  Routes.m
//  everest game
//
//  Created by Tom Huynen on 9/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Camp.h"
#import "Utils.h"
#import "CampManager.h"

@interface Camp (PrivateMethods)
-(void) setup;
-(void) updateMaterial;
@end


@implementation Camp
@synthesize campId;
@synthesize material;

-(id) initWithId:(int)i height:(int)h distance:(int)d boxRight:(int)br
{
    if( (self=[super init]))
    {
        utils = [Utils current];
        
        campId = i;
        height = h;
        distance = d;
        boxRight = br;
        
        [self display];
	}
	return self;
}

-(void)display
{
    imgHolder = [CCSprite node];
    imgNight = [CCSprite node];
    imgDay = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"camp%d.png", campId]];
    boxHolder = [CCSprite node];
    box = [CCSprite spriteWithSpriteFrameName:@"box1.png"];
    materialtxt = [CCLabelBMFont labelWithString:@"110kg" fntFile:@"material.fnt"];
    
    boxHolder.position = ccp(boxRight * [[[CampManager current].spaceCampToBox objectAtIndex:campId] integerValue], 0);
    
    [self addChild:imgHolder];
    [imgHolder addChild:imgNight];
    [imgHolder addChild:imgDay];
    [imgHolder addChild:boxHolder];
    [boxHolder addChild:box];
    [boxHolder addChild:materialtxt];
}

-(void)addMaterial:(int)amount
{
    material += amount;
    [self updateMaterial];
}

-(void)removeMaterial:(int)amount
{
    material -= amount;
    [self updateMaterial];
}

-(void)updateMaterial
{
    [materialtxt setString:[NSString stringWithFormat:@"%dkg", material]];
    
    CCSpriteFrame *frame;
    
    if(material < 15)
    {
        frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box1.png"];
    }
    else if(material > 15 && material < 30)
    {
        frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box2.png"];
    }
    else
    {
        frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box3.png"];
    }
    
    [box setDisplayFrame:frame];
}

- (void) setup
{
    
}

-(void) dealloc
{
    [super dealloc];
}

@end