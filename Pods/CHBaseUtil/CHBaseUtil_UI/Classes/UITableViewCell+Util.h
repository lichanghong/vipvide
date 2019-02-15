//
//  UITableViewCell+Util.h
//  CHBaseUtil
//
//  Created by lichanghong on 15/03/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell(Util) 

+ (CGFloat)cellHeight;
+ (instancetype)createCellFromxib;

+ (NSString *)cellIdentifier;
+ (void)registToTableView:(UITableView *)tableView;

@end
