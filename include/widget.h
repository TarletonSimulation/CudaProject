#if	!defined( __tsx__widget__ )
#	 define	  __tsx__widget__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/action.h>

namespace	tsx{

	class	widget_base
	:	public	winfo_t{
		public:
				 widget_base();
				 widget_base(const Rectangle &, const Point &);
				~widget_base();

			bool	showing()	const;
			bool	created()	const;
			bool	active()	const;

			ulong	win_id()	const;		// XServer window id //
			ulong	pwin_id()	const;		// XServer parent window id //
			XID	rwin_id()	const;		// XServer window resource id //
		protected:
		private:
		Rectangle	max_g, min_g;	// max and min geometry of window // not controlled by XServer //
		Point		max_p, min_p;	// max and min position of window //
	};


	class	Widget
	:	public	widget_base,
		public	Action{
		public:
					 Widget();
					 Widget(const Rectangle &,const Point &);
					~Widget();

	typedef	std::list<Action *>	ActionList;
		
			bool		create_action(const std::string &, Handler::Caller, void *, void * =null);
			bool		destroy_action(const std::string &);

			uint		action_count()	const;

		const	ActionList &	actions()	const;
			ActionList &	actions_ref();
			ActionList *	actions_pointer();

			bool		connect_action(const std::string &, Handler::Caller, void *, void * =null);
			bool		disconnect_action(const std::string &, Handler::Caller);

		const	Widget	&	widget()	const;
			Widget	*	widget_pointer();
			Widget	&	widget_ref();

virtual	std::list<int>	operator	()(const std::string &);

		protected:
			Widget	*	wparent;
			bool		connect_display(xDisplay *);
			void		remove_display();

			xDisplay *	xdisplay;
			ActionList	xactions;
		private:
	};



	class	Window
	:	public	Widget{
		public:
	typedef	std::list<Widget *>	WidgetList;

					 Window(){}
					~Window(){}

		const	Window	&	window()	const;
			Window	*	window_pointer();
			Window	&	window_ref();
		protected:
			WidgetList	wlist;
		private:
	};

}

#endif	// end __tsx__widget__
