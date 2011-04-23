// CPControl+Integration.j
// AldrinKit
// 
// Created by Aldrin Martoq on March 25, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import "CPControlAttributeInspector.j"

@implementation CPControl (Integration)

- (void)atlasPopulateAttributeInspectorClasses:(CPMutableArray)classes {
    [super atlasPopulateAttributeInspectorClasses:classes];

    [classes addObject:[CPControlAttributeInspector class]];
}

@end
