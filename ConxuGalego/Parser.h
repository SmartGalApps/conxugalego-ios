/*
 * This file is part of ConxuGalego.

 * ConxuGalego is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * ConxuGalego is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with ConxuGalego.  If not, see <http://www.gnu.org/licenses/>.
 */
//
//  Parser.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerbalTime.h"

@interface Parser : NSObject

+(NSArray *)parse:(NSString *) text;

@end
