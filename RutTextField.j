// RutTextField.j
// AldrinKit
// 
// Created by Aldrin Martoq on April 22, 2011.
// Copyright (C) 2011 Aldrin Martoq.

@import <AppKit/CPTextField.j>

@implementation RutTextField : CPSearchField {
    BOOL rutValido;
}

- (BOOL)rutValido {
    return rutValido;
}

- (CPString)rutValue {
    var T = [self stringValue];
    while (T.indexOf(".") != -1) {
        T = T.replace(".", "");
    }
    while (T.indexOf("-") != -1) {
        T = T.replace("-", "");
    }
    if (T.length > 1) {
        var d = T.charAt(T.length - 1);
        T = T.substring(0, T.length - 1);

        return T;
    }

    return nil;
}

- (void)validaFormatea {
    var T = [self stringValue];
    while (T.indexOf(".") != -1) {
        T = T.replace(".", "");
    }
    while (T.indexOf("-") != -1) {
        T = T.replace("-", "");
    }
    var rutValido = false;
    if (T.length > 1) {
        var d = T.charAt(T.length - 1);
        T = T.substring(0, T.length - 1);

        var M=0,S=1,X=T;
        for(;X;X=Math.floor(X/10))
            S=(S+X%10*(9-M++%6))%11;

        if (S) {
            rutValido = (d == (S-1));
        } else {
            rutValido = (d == 'k' || d == 'K');
        }

        var N = "";
        while (T.length > 3) {
            N = "." + T.substr(T.length - 3) + N;
            T = T.substring(0, T.length - 3);
        }
        T = T + N + "-" + d;
    }

    [self setValue:rutValido forKey:@"rutValido"];

    [self setStringValue:T];
}

- (void)cancelOperation:(id)sender {
    [self setStringValue:""];
    [self textDidChange:null];
    [self _updateCancelButtonVisibility];
}

- (void)textDidChange:(CPNotification)aNotification {
    [super textDidChange:aNotification];
    [self validaFormatea];
}

@end
