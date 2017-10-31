#if	!defined( __tsx__widget__ )
#	 define	  __tsx__widget__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/action.h>

#include <tsx/bits/widget.h>

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
	:	public	widget_base{
		public:
					 Widget(xDisplay * =null);
					 Widget(const Rectangle &,const Point &, xDisplay * =null);
			virtual		~Widget();
	
	typedef	std::list<Widget *>	WidgetList;
	typedef	std::list<Action *>	ActionList;
	typedef	std::list<int>		ActionReturn;
			
		friend	Widget	&	create_widget(Widget &, const Rectangle &, const Point &);
		static	Widget	&	create(Widget &, const Rectangle &, const Point &);
			Widget	&	create(const Rectangle &, const Point &);

		friend	Widget	&	destroy_widget(Widget &, Widget &);
		static	Widget	&	destroy(Widget &, Widget &);
			Widget	&	destroy(Widget &);

		static	void		size(Widget &, float, float);
		static	void		size(Widget &, const Rectangle &);
			void		size(float, float);
			void		size(const Rectangle &);

	static	const	Rectangle &	size(const Widget &);
		const	Rectangle &	size()	const;

		// only accepts x and y values //
		static	void		position(Widget &, float, float);
		static	void		position(Widget &, const Point &);
			void		position(float, float);
			void		position(const Point &);
	
	static	const	Point	&	position(const Widget &);
		const	Point	&	position()	const;

		static	void		show(Widget &);
			void		show();

		static	void		show_all(Widget &);
			void		show_all();

		static	bool		showing(const Widget &);
			bool		showing()	const;

		static	bool		created(const Widget &);
			bool		created()	const;

		static	void		hide(Widget &);
			void		hide();

		static	void		signal_blocked(const Widget &);
			void		signal_blocked()	const;

		static	bool		has_children(const Widget &);
			bool		has_children()		const;
		
		// general action callers //
		static	ActionReturn	on_button_press(Widget &);
			ActionReturn 	on_button_press();

		static	ActionReturn	on_button_release(Widget &);
			ActionReturn 	on_button_release();

		static	ActionReturn	on_activate(Widget &);
			ActionReturn 	on_activate();

		static	ActionReturn	on_deactivate(Widget &);
			ActionReturn 	on_deactivate();

		static	ActionReturn	on_raise(Widget &);
			ActionReturn 	on_raise();

		static	ActionReturn	on_key_press(Widget &);
			ActionReturn 	on_key_press();

		static	ActionReturn	on_key_release(Widget &);
			ActionReturn 	on_key_release();

		static	ActionReturn	on_expose(Widget &);
			ActionReturn 	on_expose();
			
		static	ActionReturn	on_configure(Widget &);
			ActionReturn 	on_configure();
		
		static	bool		needs_resize(const Widget &);
			bool		needs_resize()		const;

		static	bool		needs_repos(const Widget &);
			bool		needs_repos()		const;

		static	bool		needs_reconfigure(const Widget &);
			bool		needs_reconfigure()	const;
		
			bool		create_action(const std::string &, Handler::Caller, void *, void * =null);
			bool		destroy_action(const std::string &);

		static	uint		action_count(const Widget &);
			uint		action_count()		const;
			
		static	bool		connect_action(Widget &, const std::string &, Handler::Caller, void *, void * =null);
			bool		connect_action(const std::string &, Handler::Caller, void *, void * =null);

		static	bool		disconnect_action(Widget &, const std::string &, Handler::Caller);
			bool		disconnect_action(const std::string &, Handler::Caller);
		
		// base class values //
		const	ActionList &	actions()		const;
			ActionList &	actions_ref();
			ActionList *	actions_pointer();

		const	Widget	&	widget()		const;
			Widget	*	widget_pointer();
			Widget	&	widget_ref();

		const	WidgetList &	children()		const;
			WidgetList &	children_ref();
			WidgetList *	children_pointer();
		
		// ops //
virtual	std::list<int>	operator	()(const std::string &);

		protected:
			// parent data //
			Widget	 *	wparent;
			xDisplay *	xdisplay;

			bool		connect_display(xDisplay *);
			void		remove_display();
			ActionList	xactions;

			WidgetList	child_list;

			XSizeHints *	size_hints;
			XWMHints *	wm_hints;
			XClassHint *	class_hint;
		private:
	};



	Widget	&	create_widget(Widget &, const Rectangle &, const Point &);
	Widget	&	destroy_widget(Widget &, const Widget &);


}

#endif	// end __tsx__widget__
