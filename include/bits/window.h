#if	!defined( __tsx__window_bits__ )
#	 define	  __tsx__window_bits__

// this file includes window event masks as well as window bits //

namespace tsx{
	typedef	long	xWindowBaseType;
	typedef	long	LineMask;

const	long	XWIN_MIN_WIDTH			= 1;
const	long	XWIN_MIN_HEIGHT			= 1;	// X11 min value //

// cloned values // needed for namespace reasons //
const	long	XEVT_NO_EVENT			= NoEventMask;
const	long	XEVT_BUTTON_PRESS_MASK		= ButtonPressMask;
const	long	XEVT_BUTTON_RELEASE_MASK	= ButtonReleaseMask;
const	long	XEVT_BUTTON_MOTION_MASK		= ButtonMotionMask;
const	long	XEVT_BUTTON1_MOTION_MASK	= Button1MotionMask;
const	long	XEVT_BUTTON2_MOTION_MASK	= Button2MotionMask;
const	long	XEVT_BUTTON3_MOTION_MASK	= Button3MotionMask;
const	long	XEVT_BUTTON4_MOTION_MASK	= Button4MotionMask;
const	long	XEVT_BUTTON5_MOTION_MASK	= Button5MotionMask;
const	long	XEVT_KEY_PRESS_MASK		= KeyPressMask;
const	long	XEVT_KEY_RELEASE_MASK		= KeyReleaseMask;
const	long	XEVT_POINTER_MOTION_MASK	= PointerMotionMask;
const	long	XEVT_POINTER_HINT_MASK		= PointerMotionHintMask;
const	long	XEVT_RESIZE_REDIRECT		= ResizeRedirectMask;
const	long	XEVT_STRUCTURE_NOTIFY_MASK	= StructureNotifyMask;
const	long	XEVT_SUBSTRUCT_NOTIFY_MASK	= SubstructureNotifyMask;
const	long	XEVT_SUBSTRUCT_REDIRECT_MASK	= SubstructureRedirectMask;
const	long	XEVT_FOCUS_CHANGE_MASK		= FocusChangeMask;
const	long	XEVT_PROPERTY_CHANGE_MASK	= PropertyChangeMask;
const	long	XEVT_COLORMAP_CHANGE_MASK	= ColormapChangeMask;
const	long	XEVT_OWNER_GRAB_BUTTON_MASK	= OwnerGrabButtonMask;
const	long	XEVT_ENTER_WINDOW_MASK		= EnterWindowMask;
const	long	XEVT_LEAVE_WINDOW_MASK		= LeaveWindowMask;

const	long	XEVT_WINDOW_MASK		= XEVT_ENTER_WINDOW_MASK | XEVT_LEAVE_WINDOW_MASK;
const	long	XEVT_BUTTON_MASK		= XEVT_BUTTON_PRESS_MASK | XEVT_BUTTON_RELEASE_MASK;
const	long	XEVT_KEY_MASK			= XEVT_KEY_PRESS_MASK | XEVT_KEY_RELEASE_MASK;
const	long	XEVT_POINTER_MASK		= XEVT_POINTER_MOTION_MASK | XEVT_POINTER_HINT_MASK;
const	long	XEVT_BUTTON_FULL_MOTION_MASK	= XEVT_BUTTON_MOTION_MASK | XEVT_BUTTON1_MOTION_MASK | XEVT_BUTTON2_MOTION_MASK |\
							XEVT_BUTTON3_MOTION_MASK | XEVT_BUTTON4_MOTION_MASK | XEVT_BUTTON5_MOTION_MASK;
const	long	XEVT_BUTTON_FULL_MASK		= XEVT_BUTTON_MASK | XEVT_BUTTON_FULL_MOTION_MASK;
const	long	XEVT_DEFAULT_WINDOW_MASK	= XEVT_BUTTON_PRESS_MASK | XEVT_WINDOW_MASK | XEVT_STRUCTURE_NOTIFY_MASK;
const	long	XEVT_DEFAULT_APP_MASK		= XEVT_BUTTON_MASK | XEVT_KEY_MASK | XEVT_WINDOW_MASK | XEVT_POINTER_MASK | XEVT_BUTTON_FULL_MOTION_MASK | XEVT_RESIZE_REDIRECT | XEVT_PROPERTY_CHANGE_MASK;

// window attribute masks //
const	long	XWIN_ATTR_BACKGROUND_PIXEL	= CWBackPixel;
const	long	XWIN_ATTR_BORDER_PIXEL		= CWBorderPixel;
const	long	XWIN_ATTR_BACKGROUND_PIXMAP	= CWBackPixmap;
const	long	XWIN_ATTR_BORDER_PIXMAP		= CWBorderPixmap;
const	long	XWIN_ATTR_SAVE_UNDER		= CWSaveUnder;
const	long	XWIN_ATTR_OVERRIDE_REDIRECT	= CWOverrideRedirect;
const	long	XWIN_ATTR_EVENT_MASK		= CWEventMask;
const	long	XWIN_ATTR_DONT_PROPAGATE	= CWDontPropagate;
const	long	XWIN_ATTR_CURSOR		= CWCursor;
const	long	XWIN_ATTR_COLORMAP		= CWColormap;
const	long	XWIN_ATTR_BACKING_PLANES	= CWBackingPlanes;
const	long	XWIN_ATTR_BACKING_PIXEL		= CWBackingPixel;
const	long	XWIN_ATTR_BACKING_STORE		= CWBackingStore;
const	long	XWIN_ATTR_BIT_GRAVITY		= CWBitGravity;
const	long	XWIN_ATTR_WINDOW_GRAVITY	= CWWinGravity;

const	long	XWIN_ATTR_DEFAULT		= XWIN_ATTR_EVENT_MASK | XWIN_ATTR_BACKGROUND_PIXEL | XWIN_ATTR_BORDER_PIXEL;

}

#endif
