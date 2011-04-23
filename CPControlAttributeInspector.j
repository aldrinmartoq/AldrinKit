// CPControlAttributeInspector.j
// AldrinKit
// 
// Created by Aldrin Martoq on April 22, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>
@import <AppKit/CPButton.j>

@implementation CPControlAttributeInspector : AKInspector {
    @outlet CPPopUpButton       align;
    @outlet CPTextField         fontSize;
    @outlet CPButton            bold;
    @outlet CPButton            underline;
    @outlet CPButton            italic;
}

- (CPString)label {
    return @"Extras";
}

- (CPString)viewCibName {
    return @"CPControlAttributeInspector";
}

- (void)awakeFromCib {
    [align removeAllItems];
    [align addItemWithTitle:@"Left"];
    [align addItemWithTitle:@"Right"];
    [align addItemWithTitle:@"Center"];
    [align addItemWithTitle:@"Justified"];
    [align addItemWithTitle:@"Natural"];

    [align setTarget:self];
    [align setAction:@selector(change:)];

    [bold setButtonType:6];
    [underline setButtonType:6];
    [italic setButtonType:6];
}

- (void)change:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var a = [align indexOfItem:[align selectedItem]];
    for (var i=0,len=inspectedObjects.length; i< len; i++) {
        [inspectedObjects[i] setAlignment:a];
    }
}

- (void)refresh {
    var inspectedObjects = [self inspectedObjects];
    var oldVal = null;

    for (var i=0,len=inspectedObjects.length; i< len; i++) {
        var newVal = [inspectedObjects[i] alignment];
        if (oldVal != null && oldVal != newVal) {
            [align selectItem:null];
            return;
        }
        oldVal = newVal;
    }
    [align selectItemAtIndex:oldVal];
}

@end
