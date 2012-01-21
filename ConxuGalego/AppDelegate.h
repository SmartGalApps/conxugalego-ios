//
//  AppDelegate.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConjugateViewController.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    ConjugateViewController *conjugateViewController;
    ViewController *viewController;
}

@property (strong, nonatomic) ConjugateViewController *conjugateViewController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UIWindow *window;

@end
