//
//  MessageTableViewCell.m
//  Messenger
//
//  Created by Ignacio Romero Zurbuchen on 9/1/14.
//  Copyright (c) 2014 Slack Technologies, Inc. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews
{
    [self.contentView addSubview:self.tumbnailView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.attachmentView];

    NSDictionary *views = @{@"tumbnailView": self.tumbnailView,
                            @"titleLabel": self.titleLabel,
                            @"bodyLabel": self.bodyLabel,
                            @"attachmentView": self.attachmentView,
                            };
    
    NSDictionary *metrics = @{@"tumbSize": @(kAvatarSize),
                              @"trailing": @10,
                              @"leading": @5,
                              @"attchSize": @80,
                              };
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[tumbnailView(tumbSize)]-trailing-[titleLabel(>=0)]-trailing-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[tumbnailView(tumbSize)]-trailing-[bodyLabel(>=0)]-trailing-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[tumbnailView(tumbSize)]-trailing-[attachmentView]-trailing-|" options:0 metrics:metrics views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-trailing-[tumbnailView(tumbSize)]-(>=0)-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[titleLabel]-leading-[bodyLabel(>=0)]-leading-[attachmentView(>=0,<=attchSize)]-trailing-|" options:0 metrics:metrics views:views]];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    self.bodyLabel.font = [UIFont systemFontOfSize:16.0];
    self.tumbnailView.image = nil;
    self.attachmentView.image = nil;
}

#pragma mark - Getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.numberOfLines = 0;

        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel
{
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bodyLabel.backgroundColor = [UIColor clearColor];
        _bodyLabel.userInteractionEnabled = NO;
        _bodyLabel.numberOfLines = 0;
        
        _bodyLabel.font = [UIFont systemFontOfSize:16.0];
        _bodyLabel.textColor = [UIColor darkGrayColor];
    }
    return _bodyLabel;
}

- (UIImageView *)tumbnailView
{
    if (!_tumbnailView) {
        _tumbnailView = [UIImageView new];
        _tumbnailView.translatesAutoresizingMaskIntoConstraints = NO;
        _tumbnailView.userInteractionEnabled = NO;
        _tumbnailView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
        _tumbnailView.layer.cornerRadius = kAvatarSize/2.0;
        _tumbnailView.layer.masksToBounds = YES;
    }
    return _tumbnailView;
}

- (UIImageView *)attachmentView
{
    if (!_attachmentView) {
        _attachmentView = [UIImageView new];
        _attachmentView.translatesAutoresizingMaskIntoConstraints = NO;
        _attachmentView.userInteractionEnabled = NO;
        _attachmentView.backgroundColor = [UIColor clearColor];
        _attachmentView.contentMode = UIViewContentModeCenter;
        
        _attachmentView.layer.cornerRadius = kAvatarSize/4.0;
        _attachmentView.layer.masksToBounds = YES;
    }
    return _attachmentView;
}

- (BOOL)needsPlaceholder
{
    return self.tumbnailView.image ? NO : YES;
}

@end
