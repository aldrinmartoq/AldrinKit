// CPControlAttributeInspector.j
// AldrinKit
// 
// Created by Aldrin Martoq on April 22, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AtlasKit/AtlasKit.j>

@implementation CPControlAttributeInspector : AKInspector {
    @outlet CPPopUpButton       align;
    @outlet CPTextField         fontSize;
    @outlet CPButton            bold;
    @outlet CPButton            underline;
    @outlet CPButton            italic;
    @outlet CPCheckBox          bordered;
    @outlet CPCheckBox          selectable;
    @outlet CPCheckBox          editable;
    @outlet CPCheckBox          enabled;
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
    [align setAction:@selector(textAlign:)];

    [bold setButtonType:6];
    [underline setButtonType:6];
    [italic setButtonType:6];
}

- (void)textAlign:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var a = [align indexOfItem:[align selectedItem]];
    for (var i=0,len=inspectedObjects.length; i< len; i++) {
        [inspectedObjects[i] setAlignment:a];
    }
}

- (@action)changeBordered:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var v = [bordered state];
    CPLog.debug("bordered change: " + v);
    for (var i=0,len=inspectedObjects.length; i<len; i++) {
        var o = inspectedObjects[i];
        if ([o respondsToSelector:@selector(setBordered:)]) {
            [o setBordered:v];
        }
    }
}

- (@action)changeSelectable:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var v = [selectable state];
    CPLog.debug("selectable change: " + v);
    for (var i=0,len=inspectedObjects.length; i<len; i++) {
        var o = inspectedObjects[i];
        if ([o respondsToSelector:@selector(setSelectable:)]) {
            [o setSelectable:v];
        }
    }
}

- (@action)changeEditable:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var v = [editable state];
    CPLog.debug("editable change: " + v);
    for (var i=0,len=inspectedObjects.length; i<len; i++) {
        var o = inspectedObjects[i];
        if ([o respondsToSelector:@selector(setEditable:)]) {
            [o setEditable:v];
        }
    }
}

- (@action)changeEnabled:(id)sender {
    var inspectedObjects = [self inspectedObjects];
    var v = [enable state];
    CPLog.debug("enabled change: " + v);
    for (var i=0,len=inspectedObjects.length; i<len; i++) {
        var o = inspectedObjects[i];
        if ([o respondsToSelector:@selector(setEnabled:)]) {
            [o setEnabled:v];
        }
    }
}

- (void)refresh {
    var inspectedObjects = [self inspectedObjects];
    var oldVal = null;

    for (var i=0,len=inspectedObjects.length; i< len; i++) {
        var o = inspectedObjects[i];
        var newVal = [o alignment];
        if (oldVal != null && oldVal != newVal) {
            oldVal = null;
            break;
        }
        oldVal = newVal;
    }
    [align selectItemAtIndex:oldVal];

    [bordered takeValueFromKeyPath:"bordered" ofObjects:inspectedObjects];
    [selectable takeValueFromKeyPath:"selectable" ofObjects:inspectedObjects];
    [editable takeValueFromKeyPath:"editable" ofObjects:inspectedObjects];
    [enabled takeValueFromKeyPath:"enabled" ofObjects:inspectedObjects];
}

@end
