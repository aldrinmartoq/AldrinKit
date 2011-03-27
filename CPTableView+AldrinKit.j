// AldrinKit.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AppKit/CPTableView.j>

@implementation TableView : CPTableView {
}



@end

@implementation TableView (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder {
    self = [super initWithCoder:aCoder];

    if (self) {
        
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder {
    [super encodeWithCoder:aCoder];
}

@end