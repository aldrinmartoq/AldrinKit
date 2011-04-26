// CPTabView+Integration.j
// AldrinKit
// 
// Created by Aldrin Martoq on April 22, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import "CPTabViewAttributeInspector.j"

@implementation CPTabView (Integration)

- (void)atlasPopulateAttributeInspectorClasses:(CPMutableArray)classes {
    [super atlasPopulateAttributeInspectorClasses:classes];

    [classes addObject:[CPTabViewAttributeInspector class]];
}

@end
