//
//  UITableViewCell+Util.m
//  CHBaseUtil
//
//  Created by lichanghong on 15/03/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UITableViewCell+Util.h"

@implementation UITableViewCell(Util)


+ (CGFloat)cellHeight{
    return 44;
}

+ (instancetype)createCellFromxib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registToTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:[self cellIdentifier] bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:[self cellIdentifier]];
}


@end
