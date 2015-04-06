//
//  MainScreen.m
//  Its Raining Men and Ghosts
//
//  Created by vasundhara bhatia  on 09/03/15.
//  Copyright (c) 2015 Vasundhara. All rights reserved.
//

#import "MainScreen.h"
#import "WelcomeScreen.h"
@interface MainScreen ()
@property BOOL sceneCreated;
@property int score;
@property int ballCount; @end
@implementation MainScreen


- (void)didMoveToView:(SKView *)view {
    if (!self.sceneCreated) {
        self.score = 0;
        self.ballCount = 40;
        [self initMainScreen];
        self.sceneCreated = YES;
        self.physicsWorld.gravity = CGVectorMake(0, -1.0);
    }
    
}

- (void) initMainScreen {
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKSpriteNode *girlNode = [self createArcherNode];
    
    girlNode.position = CGPointMake(CGRectGetMaxX(self.frame)-30, CGRectGetMidY(self.frame));
    [self addChild:girlNode];
    SKAction *releaseMonsters = [SKAction sequence:@[ [SKAction performSelector:@selector(createMonsterNode) onTarget:self], [SKAction waitForDuration:1] ]];
    SKAction *releaseMen = [SKAction sequence:@[ [SKAction performSelector:@selector(createManNode) onTarget:self], [SKAction waitForDuration:3] ]];
    [self runAction: [SKAction repeatAction:releaseMonsters count:self.ballCount]];
    [self runAction: [SKAction repeatAction:releaseMen count:self.ballCount]];

}

- (SKSpriteNode *)createArcherNode {
    SKSpriteNode *girlNode = [[SKSpriteNode alloc] initWithImageNamed:@"Superhero-girl-in-purple.png"];
    girlNode.name = @"girlNode";
    return girlNode;
}


- (SKSpriteNode *) createLightNode {
    SKSpriteNode *lightning = [[SKSpriteNode alloc] initWithImageNamed:@"lightning.png"];
    lightning.position = CGPointMake(CGRectGetMaxX(self.frame)-30, CGRectGetMidY(self.frame));
    lightning.name = @"arrowNode";
    lightning.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:lightning.frame.size];
    lightning.physicsBody.usesPreciseCollisionDetection = YES;
    lightning.physicsBody.affectedByGravity=false;
    return lightning;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *girlNode = [self childNodeWithName:@"girlNode"];
    if (girlNode != nil) {
        
        SKAction *shootArrow = [SKAction runBlock:^{ SKNode *lightNode = [self createLightNode];
            [self addChild:lightNode];
            
            [lightNode.physicsBody applyImpulse:CGVectorMake(-90,0)];
        }];
        SKAction *sequence = [SKAction sequence:@[shootArrow]];
        [girlNode runAction:sequence]; } }

- (void) createMonsterNode {
    SKSpriteNode *monster = [[SKSpriteNode alloc] initWithImageNamed:@"monster.png"];
    monster.position = CGPointMake(randomBetween(0, self.size.width-50), self.size.height-50);
    monster.name = @"monsterNode";
    monster.physicsBody =[SKPhysicsBody bodyWithCircleOfRadius:(monster.size.width/2)-7];
    monster.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:monster];
}
- (void) createManNode {
    SKSpriteNode *monster = [[SKSpriteNode alloc] initWithImageNamed:@"boy_3.png"];
    monster.position = CGPointMake(randomBetween(0, self.size.width-30), self.size.height-50);
    monster.name = @"manNode";
    monster.physicsBody =[SKPhysicsBody bodyWithCircleOfRadius:(monster.size.width/2)-7];
    monster.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:monster];
}

static inline CGFloat randomFloat() {
    return rand() / (CGFloat) RAND_MAX;
}
static inline CGFloat randomBetween(CGFloat low, CGFloat high) {
    return randomFloat() * (high - low) + low;
}
@end
