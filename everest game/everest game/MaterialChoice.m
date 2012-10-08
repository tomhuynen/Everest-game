//
//  TimeWindow.m
//  everest game
//
//  Created by Tom Huynen on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MaterialChoice.h"

@interface MaterialChoice (PrivateMethods)
-(void)display;
-(void)setup;
-(void)hide;
@end;

@implementation MaterialChoice
@synthesize lastAmountChoosen;

static MaterialChoice* current;

-(id)init
{
    if(self = [super init])
    {
        current = self;
        
        [self setup];
        [self display];
    }
    
    return self;
}

-(void)setup
{
    utils = [Utils current];
    
    rectWidth = [utils relativeDistance:151 horizontal:YES];
    rectHeight = [utils relativeDistance:166 horizontal:NO];
    
    int yPos = [utils relativeDistance:323 horizontal:NO];
    
    bb0 = CGRectMake([utils relativeDistance:173 horizontal:YES], yPos, rectWidth, rectHeight);
    bb1 = CGRectMake([utils relativeDistance:323 horizontal:YES], yPos, rectWidth, rectHeight);
    bb2 = CGRectMake([utils relativeDistance:487 horizontal:YES], yPos, rectWidth, rectHeight);
    bb3 = CGRectMake([utils relativeDistance:662 horizontal:YES], yPos, rectWidth, rectHeight);
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    
    bbs = [[NSArray arrayWithObjects:[NSValue valueWithCGRect:bb0],
                                     [NSValue valueWithCGRect:bb1],
                                     [NSValue valueWithCGRect:bb2],
                                     [NSValue valueWithCGRect:bb3], nil] retain];
    
    materialAmounts = [[NSArray arrayWithObjects:[NSNumber numberWithInt:0],
                                    [NSNumber numberWithInt:5],
                                    [NSNumber numberWithInt:10],
                                    [NSNumber numberWithInt:15],
                                    nil] retain];
    amountIsChosen = NO;
    isActive = NO;
}

-(void)display
{
    holder = [CCSprite spriteWithFile:@"select-weight.png"];
    holder.position = [utils relativePointByCoordinates:1024/2 ypos:786/2];
    holder.opacity = 0;
    
    fade = [CCSprite spriteWithFile:@"fade.jpg"];
    fade.anchorPoint = ccp(0, 0);
    fade.opacity = 0;
    
    [self addChild:fade];
    [self addChild:holder];
}

-(void)show
{
    holder.opacity = 255;
    fade.opacity = 60;
    isActive = YES;
}

-(void)selectSpriteForTouch:(UITouch*)touch
{
    int count = [bbs count];
    
    for(int i=0; i < count; i++)
    {
        CGRect bb = [[bbs objectAtIndex:i] CGRectValue];
        
        if(CGRectContainsPoint(bb, [self convertTouchToNodeSpace: touch]))
        {
            lastAmountChoosen = [[materialAmounts objectAtIndex:i] integerValue];
            amountIsChosen = YES;
            break;
        }
    }
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(isActive == YES)
    {
        [self selectSpriteForTouch:touch];
        return YES;
    }
        
    return NO;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{

}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(amountIsChosen == YES)
    {
        holder.opacity = 0;
        fade.opacity = 0;
        
        amountIsChosen = NO;
        isActive = NO;
    }
}

+(MaterialChoice*) current
{
    if (current == nil)
    {
        current = [[MaterialChoice alloc] init];
    }
    
    return current;
}

@end
