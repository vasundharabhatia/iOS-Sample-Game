//
//  WelcomeScreen.m
//  Its Raining Men and Ghosts
//
//  Created by vasundhara bhatia  on 09/03/15.
//  Copyright (c) 2015 Vasundhara. All rights reserved.
//

#import "WelcomeScreen.h"
#import "MainScreen.h"

@interface WelcomeScreen ()
@property BOOL sceneCreated;
@end

@implementation WelcomeScreen

- (void) didMoveToView:(SKView *)view {
    if (!self.sceneCreated) {
        self.backgroundColor = [SKColor yellowColor ];
        self.scaleMode = SKSceneScaleModeAspectFill;
        [self addChild: [self createWelcomeNode]];
        self.sceneCreated = YES;
    }
}

- (SKLabelNode *) createWelcomeNode {
    SKLabelNode *welcomeNode = [SKLabelNode labelNodeWithFontNamed:@"Bradley Hand"];
    welcomeNode.name = @"welcomeNode";
    welcomeNode.text = @"Its Raining Men and Ghosts - Tap Screen to Play";
    welcomeNode.fontSize = 17;
    welcomeNode.fontColor = [SKColor blackColor];
    welcomeNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)); return welcomeNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *welcomeNode = [self childNodeWithName:@"welcomeNode"];
    if (welcomeNode != nil) {
    SKAction *fadeAway = [SKAction fadeOutWithDuration:1.0];
        [welcomeNode runAction:fadeAway completion:^{ SKScene *mainscreen = [[MainScreen alloc]initWithSize:self.size]; SKTransition *doors = [SKTransition doorwayWithDuration:1.0];
            [self.view presentScene:mainscreen transition:doors];
        } ];
    }
}
@end
