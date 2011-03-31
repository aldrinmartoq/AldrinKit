// CPTableView+Integration.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import "CPTableViewAttributeInspector.j"

@implementation CPTableView (Integration)

- (void)atlasPopulateAttributeInspectorClasses:(CPMutableArray)classes {
    [super atlasPopulateAttributeInspectorClasses:classes];

    [classes addObject:[CPTableViewAttributeInspector class]];
}

@end
