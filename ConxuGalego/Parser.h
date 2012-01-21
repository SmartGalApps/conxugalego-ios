//
//  Parser.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerbalTime.h"

@protocol ParserDelegate <NSObject>

-(void) doOnSuccess:(NSArray *)conjugations;
-(void) doOnNotFound;

@end

@interface Parser : NSObject

@property (nonatomic, retain) id<ParserDelegate> delegate;

-(void)parse:(NSString *) text;

@end
