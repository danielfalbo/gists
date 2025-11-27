
.global _main
.extern _putchar

.align 4

_main:
    ; prolog; save fp,lr,x19
    stp x29, x30, [sp, #-0x20]!
    str x19, [sp, #0x10]
    mov x29, sp
    ; make space for 2 dword local vars
    sub sp, sp, #0x10
    ; save argc/argv
    stp x0, x1, [sp]

    ; create autorelease pool and save into x19
    bl _objc_autoreleasePoolPush
    mov x19, x0

    ; initialize app delegate class
    bl initAppDelegate

    ; create CFString with delegate class name
    mov x0, 0
    adrp x1,     str_AppDelegate@PAGE
    add  x1, x1, str_AppDelegate@PAGEOFF
    mov x2, 0x0600 ; kCFStringEncodingASCII
    bl _CFStringCreateWithCString

    ; x0 = UIApplicationMain(argc, argv, nil, CFSTR("AppDelegate"));
    mov x3, x0
    ldr x0, [sp]
    ldr x1, [sp, #0x8]
    mov x2, #0
    bl _UIApplicationMain
    mov x7, x0 ; save retval

    ; pop autorelease pool
    mov x0, x19
    bl _objc_autoreleasePoolPop

    ; epilog
    ; restore stack pointer
    add sp, sp, 0x10
    ; restore saved registers
    ldr x19, [sp, #0x10]
    ldp x29, x30, [sp], #0x20
    ; get retval
    mov x0, x7
    ret

initAppDelegate:
    ; prolog; save fp,lr,x20
    stp x29, x30, [sp, #-0x20]!
    str x20, [sp, #0x10]
    mov x29, sp

    ; Class c = objc_allocateClassPair(objc_getClass("NSObject"), "AppDelegate", 0);
    adrp x0,     str_NSObject@PAGE
    add  x0, x0, str_NSObject@PAGEOFF
    bl _objc_getClass
    adrp x1,     str_AppDelegate@PAGE
    add  x1, x1, str_AppDelegate@PAGEOFF
    mov x2, 0
    bl _objc_allocateClassPair

    ; save the class since we'll clobber x0 several times
    mov x20, x0

    ; class_addProtocol(c, objc_getProtocol("UIApplicationDelegate"));
    adrp x0,     str_UIAppDelegate@PAGE
    add  x0, x0, str_UIAppDelegate@PAGEOFF
    bl _objc_getProtocol
    mov x1, x0
    mov x0, x20
    bl _class_addProtocol

    ; class_addMethod(c, S("application:didFinishLaunchingWithOptions:"), didFinishLaunching, "B@:@@");

    adrp x0,     str_didFinishLaunchingSel@PAGE
    add  x0, x0, str_didFinishLaunchingSel@PAGEOFF
    bl _sel_getUid
    mov x1, x0
    mov x0, x20
    adr x2, didFinishLaunching
    adrp x3, str_typestr@PAGE
    add  x3, x3, str_typestr@PAGEOFF
    bl _class_addMethod
    
    ; objc_registerClassPair(c);
    mov x0, x20
    bl _objc_registerClassPair

    ; epilog
    ldr x20, [sp, #0x10]
    ldp x29, x30, [sp], #0x20
    ret

; parameters:
; x0: self
; x1: _sel
; x2: application
; x3: launchOptions
didFinishLaunching:
    ; prolog, save fp, lr, x19-x22
    stp x29, x30, [sp, #-0x30]!
    stp x19, x20, [sp, #0x10]
    stp x21, x22, [sp, #0x20]
    mov x29, sp
    sub sp, sp, 0x20

    ; x19 = @selector(mainScreen)
    adrp x0, str_mainScreen@PAGE
    add  x0, x0, str_mainScreen@PAGEOFF
    bl _sel_getUid
    mov x19, x0

    ; objc_getClass("UIScreen")
    adrp x0, str_UIScreen@PAGE
    add  x0, x0, str_UIScreen@PAGEOFF
    bl _objc_getClass

    ; x20 = [UIScreen mainScreen]
    mov x1, x19
    bl _objc_msgSend
    mov x20, x0
    ; x19 is now free

    ; x1 = @selector(bounds)
    adrp x0, str_bounds@PAGE
    add x0, x0, str_bounds@PAGEOFF
    bl _sel_getUid
    mov x1, x0

    ; [x20 bounds]
    mov x0, x20
    bl _objc_msgSend

    stp d0, d1, [sp]
    stp d2, d3, [sp, #0x10]

    ; x19 = @selector(initWithFrame:)
    adrp x0, str_initWithFrame@PAGE
    add x0, x0, str_initWithFrame@PAGEOFF
    bl _sel_getUid
    mov x19, x0

    ; x0 = UIWindow
    adrp x0, str_UIWindow@PAGE
    add  x0, x0, str_UIWindow@PAGEOFF
    bl _objc_getClass

    ; x0 = class_createInstance(x0)
    mov x1, #0x0
    bl _class_createInstance
    ; x0 now has the instance
    
    ; x20 = [x0 initWithFrame:d]
    mov x1, x19 ;initWithFrame
    ldp d0, d1, [sp]
    ldp d2, d3, [sp, #0x10]
    bl _objc_msgSend
    mov x20, x0

    ; x19 = @selector(init)
    adrp x0, str_init@PAGE
    add x0, x0, str_init@PAGEOFF
    bl _sel_getUid
    mov x19, x0

    ; x0 = UIViewController
    adrp x0, str_UIViewController@PAGE
    add  x0, x0, str_UIViewController@PAGEOFF
    bl _objc_getClass

    ; x0 = class_createInstance(UIViewController)
    mov x1, #0x0
    bl _class_createInstance
    ; x0 now has the instance

    ; x21 = [x0 init]
    mov x1, x19 ;init
    bl _objc_msgSend
    mov x21, x0

    ; x19 = @selector(yellowColor)
    adrp x0, str_yellowColor@PAGE
    add  x0, x0, str_yellowColor@PAGEOFF
    bl _sel_getUid
    mov x19, x0

    ; x22 = [UIColor yellowColor]
    adrp x0, str_UIColor@PAGE
    add  x0, x0, str_UIColor@PAGEOFF
    bl _objc_getClass
    mov x1, x19
    bl _objc_msgSend
    mov x22, x0

    ; x19 = @selector(setBackgroundColor:)
    adrp x0, str_setBackgroundColor@PAGE
    add  x0, x0, str_setBackgroundColor@PAGEOFF
    bl _sel_getUid
    mov x19, x0

    ; x1 = @selector(view)
    adrp x0, str_view@PAGE
    add  x0, x0, str_view@PAGEOFF
    bl _sel_getUid
    mov x1, x0

    ; x0 = [[controller view] setBackgroundColor: x22];
    mov x0, x21
    bl _objc_msgSend
    mov x1, x19
    mov x2, x22
    bl _objc_msgSend

    adrp x0, str_setRoot@PAGE
    add  x0, x0, str_setRoot@PAGEOFF
    bl _sel_getUid
    mov x1, x0

    ; [window setRootViewController:viewController]
    mov x0, x20
    mov x2, x21
    bl _objc_msgSend

    ; [x20 makeKeyAndVisible]
    adrp x0, str_makeKeyAndVisible@PAGE
    add x0, x0, str_makeKeyAndVisible@PAGEOFF
    bl _sel_getUid

    mov x1, x0
    mov x0, x20
    bl _objc_msgSend

    ; return YES
    mov x0, #0x1

    ; epilog
    add sp, sp, 0x20
    ldp    x19, x20, [sp, #0x10]
    ldp    x21, x22, [sp, #0x20]
    ldp    x29, x30, [sp], #0x30
    ret

.data
str_NSObject:               .asciz "NSObject"
str_AppDelegate:            .asciz "AppDelegate"
str_UIAppDelegate:          .asciz "UIApplicationDelegate"
str_UIScreen:               .asciz "UIScreen"
str_UIWindow:               .asciz "UIWindow"
str_UIViewController:       .asciz "UIViewController"
str_UIColor:                .asciz "UIColor"

str_typestr:                .asciz "B@:@@"
str_didFinishLaunchingSel:  .asciz "application:didFinishLaunchingWithOptions:"
str_mainScreen:             .asciz "mainScreen"
str_bounds:                 .asciz "bounds"
str_initWithFrame:          .asciz "initWithFrame:"
str_makeKeyAndVisible:      .asciz "makeKeyAndVisible"
str_init:                   .asciz "init"
str_view:                   .asciz "view"
str_setBackgroundColor:     .asciz "setBackgroundColor:"
str_yellowColor:            .asciz "yellowColor"
str_setRoot:                .asciz "setRootViewController:"
