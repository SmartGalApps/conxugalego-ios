//
//  VerbalTimeCell.h
//  ConxuGalego
//
//  Created by Xurxo Méndez Pérez on 06/01/12.
//  Copyright (c) 2012 ninguna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerbalTimeCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *time;

@property (nonatomic, strong) IBOutlet UILabel *firstPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *firstPPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondPPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdPPersonLabel;

@property (nonatomic, strong) IBOutlet UILabel *firstPersonTime;
@property (nonatomic, strong) IBOutlet UILabel *secondPersonTime;
@property (nonatomic, strong) IBOutlet UILabel *thirdPersonTime;
@property (nonatomic, strong) IBOutlet UILabel *firstPPersonTime;
@property (nonatomic, strong) IBOutlet UILabel *secondPPersonTime;
@property (nonatomic, strong) IBOutlet UILabel *thirdPPersonTime;

@end